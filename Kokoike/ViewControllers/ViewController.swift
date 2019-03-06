//
//  ViewController.swift
//  Kokoike
//
//  Created by mosin on 2019/02/23.
//  Copyright © 2019 mosin. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
   
    
    
    var params: [String:String] = [:]
    
    var myLocationManager: CLLocationManager!
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var welcomText: UILabel!
    
    @IBOutlet weak var locationTable: UITableView!
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "マイリスト"
        
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied {
            return
        }
        
        myLocationManager = CLLocationManager()
        myLocationManager.allowsBackgroundLocationUpdates = true
        myLocationManager.delegate = self
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        myLocationManager.distanceFilter = 1
        
        if status == CLAuthorizationStatus.notDetermined {
            myLocationManager.requestAlwaysAuthorization()
        }
        
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        
        if let username = UserDefaults.standard.string(forKey: Constants.USER_KEYS.DISPLAY_NAME) {
            welcomText.text = username
        }
        
        if let iconURL = UserDefaults.standard.string(forKey: Constants.USER_KEYS.ICON_URL) {
            iconImageView.displayFromURL(iconURL)
        }
        
    
        myLocationManager.startUpdatingLocation()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataController = appDelegate.dataController
        
        tableViewInit()
        
        updateLocations()
    }
    
    func tableViewInit() {
        locationTable.separatorInset = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateLocations()
    }
    
    private func updateLocations() {
        locations = dataController.fetchLocations()
        reloadTable()
    }
    
    private func reloadTable() {
        locationTable.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("locationManager")
        let lastLocation = locations.last
        if let last = lastLocation {
            let eventDate = last.timestamp
            if abs(eventDate.timeIntervalSinceNow) < 15.0 {
                if let location = manager.location {
                    let lat = Float(location.coordinate.latitude)
                    let lon = Float(location.coordinate.longitude)
                    //print("緯度:\(location.coordinate.latitude) 経度:\(location.coordinate.longitude) 取得時刻:\(location.timestamp.description)")
                    func comp(json: JSON) -> Void {
                        print(comp)
                        
                        let alert: UIAlertController = UIAlertController(title: "GPSが送信されました", message: String(lat) + ", "  + String(lon) , preferredStyle: .alert)
                        let confirmAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: {
                            (action: UIAlertAction!) -> Void in
                            print("OK")
                        })
                    
                        alert.addAction(confirmAction)
                        //present(alert, animated: true, completion: nil)
                    }
                    
                    API.sharedInstance.postGPS(lat: lat, lon: lon, completion: comp)
                }
            }
        }
    }
    
    var locations: [Location] = []
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        
        cell.layoutMargins = .zero
        cell.preservesSuperviewLayoutMargins = false
        
        cell.textLabel!.text = locations[indexPath.row].name
        return cell
    }
    
    func tableView(_ table: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locationID = locations[indexPath.row].id
        locationTable.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openLocation", sender: ["id": locationID])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return [
            UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
                self.locations.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
        ]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "openLocation" {
            let detailViewController: DetailViewController = segue.destination as! DetailViewController
            detailViewController.locationID = (sender as! [String:Int32])["id"]!
        }
    }
}

