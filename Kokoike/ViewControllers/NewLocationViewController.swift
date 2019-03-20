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
    
    var displayingShopList: [JSON] = []
    
    
    override func viewDidLoad() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataController = appDelegate.dataController
        self.navigationItem.title = Constants.STRINGS.SEARCH_TITLE
        nameInput.delegate = self
        tableViewInit()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "openShopDetail" {
            let detailViewController: NewLocationDetailViewController = segue.destination as! NewLocationDetailViewController
            detailViewController.shopJSON = (sender as! [String:JSON])["shop"]!
        }
    }
    
    func tableViewInit() {
        resultTable.separatorInset = .zero
        resultTable.estimatedRowHeight = 200
        resultTable.rowHeight = 200
        resultTable.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "resultcell")
    }
    
    func searchShops() {
        guard let name = nameInput.text else { return }
        displayShops(word: name)
    }
    
    func displayShops(word: String) {
        func completion(json: JSON) -> Void {
            if json["total_hit_count"] == 0 {
                print("該当が店舗なし")
                return
            }
            
            let shops: [JSON] = json["rest"].array!
            displayingShopList = shops
            reloadTable()
        }
        API.sharedInstance.getShops(word: word, completion: completion)
    }
    
    private func reloadTable() {
        resultTable.reloadData()
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
    
    /* Table View */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayingShopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultcell", for: indexPath) as! SearchResultCell
        cell.layoutMargins = .zero
        cell.preservesSuperviewLayoutMargins = false
        cell.displayShop(displayingShopList[indexPath.row])
        return cell
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath: IndexPath) {
        let json = displayingShopList[indexPath.row]
        resultTable.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openShopDetail", sender: ["shop": json])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    /* TableView */
}
