//
//  Forecast.swift
//  WeatherApp
//
//  Created by Alexey on 12/17/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _lowTemp: Double!
    var _highTemp: Double!
    var _weatherType: String!
    
    
    var date: String! {
        if _date == nil {
            _date = "No Date"
        }
        return _date
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = -999.0
        }
        return _lowTemp
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 999.0
        }
        return _highTemp
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = "Fatal Error!!!!"
        }
        return _weatherType
    }
    
    init (weatherDict: [String: Any]) {
        if let temp = weatherDict ["temp"] as? [String: Any]{
            if let min = temp ["min"] as? Double{
                let kelvinToCelsiumConversion = min - 273.15
                let kelvinToCelsium = round (kelvinToCelsiumConversion*10)/10
                self._lowTemp = kelvinToCelsium
            }
            
            if let max = temp ["max"] as? Double{
                let kelvinToCelsiumConversion = max - 273.15
                let kelvinToCelsium = round (kelvinToCelsiumConversion*10)/10
                self._highTemp = kelvinToCelsium
            }
        }
        
        if let weather = weatherDict ["weather"] as? [[String: Any]] {
            if let main = weather [0]["main"] as? String {
            self._weatherType = main
            }
        }
        
        if let date = weatherDict ["dt"] as? Double {
            let unixConvertedDate = Date (timeIntervalSince1970: date)
            let dateFormatter = DateFormatter ()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfWeek ()
        }
    }
    
}

extension Date {
    func dayOfWeek () -> String {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
