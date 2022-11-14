//
//  WeatherSections.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 05.10.2022.
//

import UIKit

struct TableSection {
    let options: [Indicators]
}

enum Indicators {
    case header
    case hourlyForecast
    case airPollution
    case dayForecast
    case feelsLike
    case visibility
    case humidity
    case precipitation
    case wind
    case pressure
    case sunsetAndSunrise
}


