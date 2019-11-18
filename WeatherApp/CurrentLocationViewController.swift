//
//  CurrentLocationViewController.swift
//  WeatherApp
//
//  Created by Kamran Nawaz on 18/11/2019.
//  Copyright © 2019 Kamran Nawaz. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mapView.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Kamran"
        annotation.subtitle = "current location"
        mapView.addAnnotation(annotation)

        //centerMap(locValue)
    }
    

    override func viewDidLoad() {
    super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true

        if let coor = mapView.userLocation.location?.coordinate{
          
    }
    
}
}
