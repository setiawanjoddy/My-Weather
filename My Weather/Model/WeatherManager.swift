//
//  WeatherManager.swift
//  My Weather
//
//  Created by Setiawan Joddy on 01/04/21.
//

import Foundation

struct WeatherManager {
    static let apiToken = "ab0e24d79a4318f3fcfc141276255763"
    static let measurementUnits = "metric"
    let mainURL = "https://api.openweathermap.org/data/2.5/weather?&appid=\(apiToken)&units=\(measurementUnits)"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(mainURL)&q=\(cityName)"

    }
    
    //Networking
    func performRequest(with urlString: String) {
        //Step 1. Create URL
        if let url = URL(string: urlString) {
            //Step 2. Create URL Session
            let session = URLSession(configuration: .default)
            //Step 3. Give the Session a "Task"
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    
                }
            }
            //Step 4. Start the Task
            task.resume()
        }
    }
    
    
    
}
