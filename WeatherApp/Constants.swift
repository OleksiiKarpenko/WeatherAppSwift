//
//  Constants.swift
//  WetherApp
//
//  Created by Alexey on 12/14/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat=\(Location.shareInstance.latitude!)"
let LONGITUDE = "&lon=\(Location.shareInstance.longitude!)"
let APP_ID = "&appid="
let API_KEY = "7a359a464f8dd748fc25bc2348f072c0"


typealias DownloadComplete = () -> ()
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"
let FORECAST_WEATHER_URL = "\(FORECAST_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"


