//
//  WeatherManager.swift
//  Clima
//
//  Created by Mohammed Hossain on 9/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=9defa614b51ba57cf819dae2053bd422&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3, Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return // exits function if nil value
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)

                    
                }
            }
            
            //4. Start the task
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            print(getConditionName(weatherId: id))
        } catch {
            print(error)
        }
    }
    
    func getConditionName(weatherId: Int) -> String {
        
        switch weatherId {
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

