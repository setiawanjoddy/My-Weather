//
//  ViewController.swift
//  My Weather
//
//  Created by Setiawan Joddy on 01/04/21.
//

import UIKit

class MyWeatherViewController: UIViewController {
    
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherTemperatureLabel: UILabel!
    @IBOutlet weak var weatherLocation: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var citySearchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        citySearchTextField.delegate = self
        //print("Hello World")
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        citySearchTextField.endEditing(true)
        //print("search button is OK")
    }
    
    @IBAction func locateButtonPressed(_ sender: UIButton) {
        print("locate button is OK")
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
