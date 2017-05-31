//
//  WetherVC.swift
//  WetherApp
//
//  Created by Alexey on 12/13/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let locationManager = CLLocationManager ()
    var currentLocation: CLLocation!
    
    var currentWeather = CurrentWeather()
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 20
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationAuthStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func locationAuthStatus () {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.shareInstance.latitude = currentLocation.coordinate.latitude
            Location.shareInstance.longitude = currentLocation.coordinate.longitude
              print(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
            
            currentWeather.downloadWeatherDetails{
                self.downloadForecastData {
                    self.updateMainVC()
                }
            }
        }
        else {
           
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData (completed: @escaping DownloadComplete) {
        
        Alamofire.request(FORECAST_WEATHER_URL).responseJSON {response in
            let result = response.result
            
            if let dict = result.value as? [String: Any] {
                if let list = dict["list"] as? [[String: Any]] {
                    
                    for obj in list {
                        
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                }
                
                self.forecasts.remove(at: 0)
                self.tableView.reloadData()
            }
            
            completed()
            
        }
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            let forecast = forecasts [indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainVC (){
        dateLabel.text = currentWeather.date
        print("\(currentWeather.currentTemp)")
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
   



    
    
}

