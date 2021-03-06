//
//  ViewController.swift
//  My Weather
//
//  Created by Setiawan Joddy on 01/04/21.
//

import UIKit
import CoreLocation

class MyWeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var weatherLocation: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var citySearchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        citySearchTextField.delegate = self
        //print("Hello World")
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        citySearchTextField.endEditing(true)
        //print("search button is OK")
    }
    
    @IBAction func locateButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        //print("locate button is OK")
    }
}

//MARK: - UITextFieldDelegate

extension MyWeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        citySearchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = citySearchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        citySearchTextField.text = ""
    }
}

extension MyWeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherTemperatureLabel.text = weather.temperatureString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.weatherLocation.text = weather.cityName
            self.weatherConditionLabel.text = weather.condition
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

extension MyWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
