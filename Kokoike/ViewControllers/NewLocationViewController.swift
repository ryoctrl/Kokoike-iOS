//
//  NewLocationViewController.swift
//  Kokoike
//
//  Created by mosin on 2019/02/26.
//  Copyright © 2019 mosin. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects
import SwiftyJSON

class NewLocationViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var dataController: DataController!

    @IBOutlet weak var resultTable: UITableView!
    
    @IBOutlet weak var nameInput: UITextField!
    
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataController = appDelegate.dataController
        self.navigationItem.title = "新規店舗 - 検索"
        nameInput.delegate = self
        tableViewInit()
    }
    
    func tableViewInit() {
        resultTable.separatorInset = .zero
        resultTable.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "resultcell")
        
    }
    
    /* キーボード閉じる系*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchShops()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches began")
        self.view.endEditing(true)
    }
    /*キーボードぞ閉じる系*/
    func searchShops() {
        guard let name = nameInput.text else { return }
        displayShops(word: name)
    }
 
    @IBAction func onClickAdd(_ sender: UIButton) {
        searchShops()
    }
    
    var displayingShopList: [JSON] = []
    
    func displayShops(word: String) {
        func completion(json: JSON) -> Void {
            if json["total_hit_count"] == 0 {
                print("該当が店舗なし")
                return
            }

            let shops: [JSON] = json["rest"].array!
            displayingShopList = shops
            reloadTable()
            for shop in shops {
                print(shop["name"])
            }
        }
        API.sharedInstance.getShops(word: word, completion: completion)
    }
    
    private func reloadTable() {
        resultTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayingShopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultcell", for: indexPath) as! SearchResultCell
        
        cell.layoutMargins = .zero
        cell.preservesSuperviewLayoutMargins = false
        
        cell.displayShop(displayingShopList[indexPath.row])
        //cell.textLabel!.text = displayingShopList[indexPath.row]["name"].string
        return cell
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath: IndexPath) {
        let json = displayingShopList[indexPath.row]
        resultTable.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openShopDetail", sender: ["shop": json])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "openShopDetail" {
            let detailViewController: NewLocationDetailViewController = segue.destination as! NewLocationDetailViewController
            detailViewController.shopJSON = (sender as! [String:JSON])["shop"]!
        }
    }
}
