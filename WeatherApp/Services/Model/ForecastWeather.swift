//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 30.10.2022.
//

import Foundation

struct ForecastWeather {
    let id = UUID()
    let main: MainWeather
    let city: WeatherData.City
}

extension ForecastWeather {
    public enum MainWeather {
        case weather(from: List)
    }
}

extension ForecastWeather {
    public enum SunPosition {
        case sunPosition(from: WeatherData.City)
    }
}
