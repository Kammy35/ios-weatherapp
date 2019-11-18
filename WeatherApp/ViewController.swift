//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kamran Nawaz on 18/11/2019.
//  Copyright © 2019 Kamran Nawaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    
    
    @IBAction func weatherButtonTapped(_ sender: UIButton) {
    getWeather()
    }

    
    func getWeather() {
        
        let locationThing: String = locationTextField.text!
        let country: String = countryTextField.text!
        let session = URLSession.shared
        print(country)
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
    
    

override func viewDidLoad() {
super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.
//getWeather()
}


}

