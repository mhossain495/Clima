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
           let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            
        //4. Start the task
            
            task.resume()
        }
    }
        
        func handle(data: Data?, response: URLResponse?, error: Error?) {
            if error != nil {
                print(error!)
                return // exits function if nil value
            }
            
            if let safeData = data {
                let dataString = String(data: safeData, encoding: .utf8)
                print(dataString)
                
            }
        }
    
        
}

