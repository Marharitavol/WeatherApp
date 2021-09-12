//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rita on 08.09.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    lazy var weatherManager = APIWeatherManager(apiKey: "2a6d8e376a69c1ae07d4a52dd0c2dfdc")
    let coordinates = Coordinates(latitude: 31.28408665595211, longitude: 51.49996417262024)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
            
            let alertController = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            }
        }
        
//        //let urlString = "https://api.forecast.io/forecast/2a6d8e376a69c1ae07d4a52dd0c2dfdc/37.8267,-122.423"
//        let baseURL = URL(string: "https://api.forecast.io/forecast/2a6d8e376a69c1ae07d4a52dd0c2dfdc/")
//        let fullURL = URL(string: "37.8267,-122.423", relativeTo: baseURL)
//       
//        let sessionConfiguration = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfiguration)
//        
//        let request = URLRequest(url: fullURL!)
//        let dataTask = session.dataTask(with: fullURL!) { (data, response, error) in
//            
//        }
//        dataTask.resume()
    }

    @IBAction func refreshButtonTapped(_ sender: UIButton) {
        
    }
    
    func updateUIWith(currentWeather: CurrentWeather) {
        
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
    }
}

