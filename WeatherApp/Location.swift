//
//  Location.swift
//  WeatherApp
//
//  Created by Alexey on 12/22/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import CoreLocation

class Location {
    static var shareInstance = Location()
    
    private init () {}
    
    var latitude: Double!
    var longitude: Double!
    
}
