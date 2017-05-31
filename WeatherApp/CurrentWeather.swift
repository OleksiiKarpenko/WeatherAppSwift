//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Alexey on 12/15/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import Alamofire




class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = "nothing"
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        dateFormater.timeStyle = .none
        let currentDate = dateFormater.string(from: Date())
        self._date = "Today is \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = "error"
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 999
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails (completed: @escaping DownloadComplete) {
        // Alamofire download
        
        Alamofire.request (CURRENT_WEATHER_URL).responseJSON { response in
         
            let result = response.result
         
            if let dict = result.value as? [String: Any] {
                
                if let name = dict ["name"] as? String{
                    self._cityName = name.capitalized
                    
                }
                print(self._cityName)
                
                if let weather = dict ["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather [0] ["main"] {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }
                
                if let main = dict ["main"] as? Dictionary <String, AnyObject> {
                    if let currentTemperature = main ["temp"] as? Double {
                       
                        let kelvinToCelsiumConversion = currentTemperature - 273.15
                        let kelvinToCelsium = round (kelvinToCelsiumConversion*10)/10
                        
                        self._currentTemp = kelvinToCelsium
                        
                        print(self._currentTemp)
                    }
                }
                completed()
            }
        }
        
        
    }
}


