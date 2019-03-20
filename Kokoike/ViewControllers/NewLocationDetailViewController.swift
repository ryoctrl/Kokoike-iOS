//
//  NewLocationDetailViewController.swift
//  Kokoike
//
//  Created by mosin on 2019/03/01.
//  Copyright © 2019 mosin. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class NewLocationDetailViewController: UIViewController, UITextFieldDelegate {
    var dataController: DataController!
    
    var shopJSON: JSON = JSON("{}")
    var shopURL: String = ""
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentInput: UITextView!
    @IBOutlet weak var commentMemoLabel: UILabel!
    
    var displayLabels: [UIView] = []
    
    override func viewDidLoad() {
        //print(shopJSON)
        displayLabels = [addressLabel, telLabel, textView, commentMemoLabel, commentInput]
        
        self.navigationItem.title = "新規店舗 - " + shopJSON["name"].stringValue
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataController = appDelegate.dataController
    
        displayDetail()
    }
    
    /* キーボード閉じる系*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*キーボードぞ閉じる系*/
    
    func displayDetail() {
        nameLabel.text = shopJSON["name"].stringValue
        addressLabel.text = shopJSON["address"].stringValue
        telLabel.text = shopJSON["tel"].stringValue
        shopURL = shopJSON["url_mobile"].stringValue

        let shopURLTitle = nameLabel.text! + " ぐるなびページ"
        
        let style = NSMutableParagraphStyle()
        let attributedString = NSMutableAttributedString(string: shopURLTitle)
        let attributeOptions: [NSAttributedString.Key:Any] = [
            .foregroundColor: UIColor.white,
            .paragraphStyle: style,
            .font: UIFont.systemFont(ofSize: 22.0)
        ]
        
        attributedString.addAttributes(attributeOptions, range: NSMakeRange(0, attributedString.length))
        
        let range = attributedString.mutableString.range(of: shopURLTitle)
        attributedString.setAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue, .link: URL(string: shopURL)!, .foregroundColor: UIColor.black, .paragraphStyle: style,], range: range)
        
        textView.attributedText = attributedString
        
        nameLabel.fitAndLineBreak()
        
        addressLabel.fitAndLineBreak()
        
        var labelFrame = nameLabel.frame
        for view in displayLabels {
            view.frame.origin.y = labelFrame.origin.y + labelFrame.size.height + 10
            if !(view is UITextView) {
                view.sizeToFit()
            }
            
            labelFrame = view.frame
        }
    }
    
    @IBAction func onClickAddButton(_ sender: UIButton) {
        let name = shopJSON["name"].stringValue
        let lat = shopJSON["latitude"].floatValue
        let lon = shopJSON["longitude"].floatValue
        let address = shopJSON["address"].stringValue
        let tel = shopJSON["tel"].stringValue
        let comment = commentInput.text
        let url = shopJSON["url_mobile"].stringValue
        let imageURL = shopJSON[Constants.GNAVI_RESPONSE.IMAGE_URLS][Constants.GNAVI_RESPONSE.IMAGE_URL1].stringValue
        dataController.registerNewLocation(name: name, address: address, tel: tel, comment: comment, url: url, imageURL: imageURL, lat: lat, lon: lon)
        navigationController?.popViewController(animated: true)
    }
}
