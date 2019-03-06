//
//  MapVIewController.swift
//  Kokoike
//
//  Created by mosin on 2019/03/06.
//  Copyright © 2019 mosin. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView? = nil
    var displayLocation: Location? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView()
        mapView?.frame = self.view.frame
        self.view.addSubview(mapView!)
        displayPinIfNeeded()
    }
    
    func setTargetPin(_ location: Location) {
        self.displayLocation = location
        displayPinIfNeeded()
    }
    
    func displayPinIfNeeded() {
        guard let mapView = mapView else { return }
        guard let location = displayLocation else { return }
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(location.lat), CLLocationDegrees(location.lon))
        pin.title = location.name
        pin.subtitle = location.address
        mapView.addAnnotation(pin)
    }
}
