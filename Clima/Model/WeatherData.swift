//
//  WeatherData.swift
//  Clima
//
//  Created by Mohammed Hossain on 9/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

// Property names in structures must match property names in JSON data
// Below structures decode JSON data

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather] //JSON weather property is in array format
}

// Main structure to refer to Main in JSON format API data
struct Main: Codable {
    let temp: Double
}

// Weather structure to refer to weather description and id (weather condition code) in JSON format API data
struct Weather: Codable {
    let description: String
    let id: Int
}
