//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kamran Nawaz on 18/11/2019.
//  Copyright © 2019 Kamran Nawaz. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
     let locationManager = CLLocationManager()
    
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
    getWeather()
    }
    
    var currentViewController = CurrentLocationViewController()

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
       
       
        print(locValue)
    }
    func getWeather() {
        
        
        let locationThing: String = locationTextField.text!
        let country: String = countryTextField.text!
        let session = URLSession.shared
        
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\( locationThing),\(country)?&units=metric&APPID=261a57931048c6dfd3c0064016fe0acc")!
        let dataTask = session.dataTask(with: weatherURL) {
        (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
        print("Error:\n\(error)")
        } else {
        if let data = data {
        let dataString = String(data: data, encoding: String.Encoding.utf8)
        print("All the weather data:\n\(dataString!)")
        if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
            if let mainDictionary = jsonObj.value(forKey: "main") as? NSDictionary {
        if let temperature = mainDictionary.value(forKey: "temp") {
        DispatchQueue.main.async {
        self.weatherLabel.text = "\(locationThing) Temperature: \(temperature)°C"
        }
        }
        } else {
        print("Error: unable to find temperature in dictionary")
        }
        } else {
        print("Error: unable to convert json data")
        }
        } else {
        print("Error: did not receive data")
        }
            }}
        dataTask.resume()
        }
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
                
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
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

    
      
}


}

