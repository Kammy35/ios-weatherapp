//
//  MapKit.swift
//  WeatherApp
//
//  Created by Kamran Nawaz on 18/11/2019.
//  Copyright © 2019 Kamran Nawaz. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {
    
    // MARK: Variables
    // investigate the type / value given to a location, span and region.
    var location = CLLocationCoordinate2D(latitude: 53.481372, longitude: -2.241486)
    var span = MKCoordinateSpan(latitudeDelta: 0.00, longitudeDelta: 0.00)
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var map: MKMapView!
    
    // MARK: Actions
    
    
    
    
    // MARK: Functions
    
    func mapFunction() {
        // location defined
       // let location = CLLocationCoordinate2D(latitude: 53.481372, longitude: -2.241486)
        
        // span and region defined
       // let span = MKCoordinateSpan(latitudeDelta: 0.00, longitudeDelta: 0.00)
        
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Code Nation"
        annotation.subtitle = "Manchester"
        map.addAnnotation(annotation)
        
    }
    
    
    
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapFunction()
        // Do any additional setup after loading the view.
    }


}
