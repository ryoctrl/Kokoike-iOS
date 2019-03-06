//
//  DetailViewController.swift
//  Kokoike
//
//  Created by mosin on 2019/02/28.
//  Copyright © 2019 mosin. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var locationID:Int32 = -1
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var urlTextView: UITextView!
    @IBOutlet weak var commentTextView: UITextView!
    
    var displayLabels: [UIView] = []
    
    override func viewDidLoad() {
        displayLabels = [addressLabel, telLabel, urlTextView, createdAtLabel, commentTextView]
        print("opening location")
        print(locationID)
        displayDetail()
    }
    
    var displayingLocation: Location? = nil
    
    func displayDetail() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataController = appDelegate.dataController!
        
        guard let location = dataController.fetchLocationById(id: locationID) else { return }
        
        displayingLocation = location
        
        nameLabel.text = location.name
        addressLabel.text = location.address
        telLabel.text = location.tel
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM月dd日 HH:mm:ss 登録"
        createdAtLabel.text = formatter.string(from: location.created_at!)
        commentTextView.text = location.comment
        
        if let url = location.url {
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
            attributedString.setAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue, .link: URL(string: url)!, .foregroundColor: UIColor.black, .paragraphStyle: style,], range: range)
            
            urlTextView.attributedText = attributedString
        }
        
        
        nameLabel.numberOfLines = 0
        nameLabel.sizeToFit()
        nameLabel.lineBreakMode = .byWordWrapping
        
        addressLabel.numberOfLines = 0
        addressLabel.sizeToFit()
        addressLabel.lineBreakMode = .byWordWrapping
        
        var labelFrame = nameLabel.frame
        for view in displayLabels {
            view.frame.origin.y = labelFrame.origin.y + labelFrame.size.height + 10
            view.sizeToFit()
            labelFrame = view.frame
        }
        

    }
    
    @IBAction func onClickMapButton(_ sender: UIButton) {
        performSegue(withIdentifier: "openmap", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        guard let location: Location = displayingLocation else { return }
        if segue.identifier == "openmap" {
            let mapViewController: MapViewController = segue.destination as! MapViewController
            mapViewController.setTargetPin(location)
        }
    }
    
}
