//
//  WeatherManager.swift
//  Clima
//
//  Created by Mohammed Hossain on 9/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=9defa614b51ba57cf819dae2053bd422&units=metric"
    var delegate: WeatherManagerDelegate?
    
    // obtain weather data based on city name
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    // obtain weather data based based on latitude and longitude
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    

    func performRequest(with urlString: String) {
        
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3, Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return // exits function if error with url
            }
            
            if let safeData = data {
                if let weather =  self.parseJSON(safeData) {
                    self.delegate?.didUpdateWeather(self, weather: weather)
                }
                
            }
        }
        
        //4. Start the task *task.resume needed or else network request won't execute
        
        task.resume()
    }
}

    // parsing JSON data to convert data into a Swift object
func parseJSON(_ weatherData: Data) -> WeatherModel? {
    let decoder = JSONDecoder()
    // do keyword starts the block of code that contains method that can throw an error
    do {
        // decode JSON data and create WeatherData object by providing WeatherData structure as a data type using .self
        // decodedData constant is of type WeatherData structure
        let decodedData = try decoder.decode(WeatherData.self, from: weatherData) // try must be used in front of method that throws error
        
        //decoded data is of type WeatherData structure thus properties of WeatherData structure can be used
        let id = decodedData.weather[0].id
        let temp = decodedData.main.temp
        let name = decodedData.name
        let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
        return weather
        
    // do-catch to handle error returns from try decode function. If the throwing method fails and raises an error, the execution will then be handled by catch block
    } catch {
        delegate?.didFailWithError(error: error)
        return nil
    }
}



}


