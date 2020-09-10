//
//  WeatherModel.swift
//  Clima
//
//  Created by Mohammed Hossain on 9/9/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    // computed property to return 1 decimal point temperature as String to a variable
    var temperatureString: String {
        return String(format: "%.1f", temperature)
        
    }
    
    // computed property to return weather condition as String to a variable
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }

    }

    
    
}
