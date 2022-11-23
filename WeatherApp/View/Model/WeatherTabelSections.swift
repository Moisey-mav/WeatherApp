//
//  WeatherTabelSections.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 19.11.2022.
//

import Foundation


struct WeatherTableSection {
    let sections: [Indicators]
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
    case footer
}
