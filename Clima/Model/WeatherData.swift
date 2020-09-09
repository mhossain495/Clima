//
//  WeatherData.swift
//  Clima
//
//  Created by Mohammed Hossain on 9/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

// Main structure to refer to Main in JSON format API data
struct Main: Decodable {
    let temp: Double
}

// Weather structure to refer to weather description and id (weather condition code) in JSON format API data
struct Weather: Decodable {
    let description: String
    let id: Int
}
