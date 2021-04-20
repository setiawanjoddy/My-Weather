//
//  WeatherManager.swift
//  My Weather
//
//  Created by Setiawan Joddy on 01/04/21.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    static let apiToken = "ab0e24d79a4318f3fcfc141276255763"
    static let measurementUnits = "metric"
    let mainURL = "https://api.openweathermap.org/data/2.5/weather?&appid=\(apiToken)&units=\(measurementUnits)"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(mainURL)&q=\(cityName)"
        performRequest(with: urlString)
        
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
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //Step 4. Start the Task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let condition = decodedData.weather[0].main
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, condition: condition)
            print(weather.temperatureString)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
