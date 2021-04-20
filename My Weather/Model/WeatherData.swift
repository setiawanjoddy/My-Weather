//
//  WeatherData.swift
//  My Weather
//
//  Created by Setiawan Joddy on 20/04/21.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
