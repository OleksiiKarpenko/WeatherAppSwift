//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Alexey on 12/21/16.
//  Copyright © 2016 Alexey. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLable: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    func configureCell (forecast: Forecast){
        
        highTemp.text = "\(forecast.highTemp)"
        lowTemp.text = "\(forecast.lowTemp)"
        weatherType.text = forecast.weatherType
        dayLable.text = forecast.date
        weatherIcon.image = UIImage (named: forecast.weatherType)
        
        
        
    }
    


}
