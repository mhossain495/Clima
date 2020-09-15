//
//  ViewController.swift
//  Clima
//



import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // locationManager.delegate = self must be written first
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
         // setting the current class, WeatherViewController as delegate
        weatherManager.delegate = self
        searchTextField.delegate = self
    
    }
}

//MARK: - UITextFieldDelegate

// extension of type WeatherViewController to adopt UITextFieldDelegate protocol
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter Location"
            return false
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use search TextField.text to get the weather for that city
        
        // Optional binding to pass search text field value to a constant and use constant
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
        
    }
    

}


//MARK: - WeatherManagerDelegate

// extension of type WeatherViewController to adopt WeatherManagerDelegate protocol
extension WeatherViewController: WeatherManagerDelegate {


func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
    DispatchQueue.main.async {
        self.temperatureLabel.text = weather.temperatureString
        // Accessing user interface images to display weather condition image
        self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        self.cityLabel.text = weather.cityName
    }
}

func didFailWithError(error: Error) {
    print(error)
}

}



//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            
        }
}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}
