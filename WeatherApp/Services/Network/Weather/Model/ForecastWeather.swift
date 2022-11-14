//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 30.10.2022.
//

import Foundation

struct ForecastWeather {
    let id = UUID()
    let mainWeather: MainWeather
    let dateWeather: DateWeather
}

extension ForecastWeather {
    public enum MainWeather {
        case weather(weather: List)
    }
}

extension ForecastWeather{
    public enum DateWeather {
        case dateWeather(date: List)
    }
}
