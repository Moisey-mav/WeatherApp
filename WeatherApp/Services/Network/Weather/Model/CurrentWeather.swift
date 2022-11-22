//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 14.10.2022.
//

import Foundation

struct CurrentWeather {

    let cityName: String
    let description: String
    let humidity: Int
    let visibility: Int

    private let temp: Double
    var tempInt: Int { return Int(temp.rounded()) }

    private let feelsLikeTemp: Double
    var feelsLikeTempInt: Int { return Int(feelsLikeTemp.rounded()) }

    private let minTemp: Double
    var minTempInt: Int { return Int(minTemp.rounded()) }

    private let maxTemp: Double
    var maxTempInt: Int { return Int(maxTemp.rounded()) }

    private let windSpeed: Double
    var windSpeedInt: Int { return Int(windSpeed) }

    private let deg: Int
    var degConvert: Float { return Float(deg) * 6.29 / 360 }
    
    private let pressure: Double
    var pressureСonverted: Int { return Int(pressure / 1.333) }

    init?(currentWeatherData: WeatherData) {
        cityName = currentWeatherData.city.name
        description = currentWeatherData.list.first?.weather.first?.description ?? "Ooops..."
        humidity = currentWeatherData.list.first?.main.humidity ?? 0
        windSpeed = currentWeatherData.list.first?.wind.speed ?? 0
        temp = currentWeatherData.list.first?.main.temp ?? 0
        feelsLikeTemp = currentWeatherData.list.first?.main.feelsLike ?? 0
        minTemp = currentWeatherData.list.first?.main.tempMin ?? 0
        maxTemp = currentWeatherData.list.first?.main.tempMax ?? 0
        visibility = currentWeatherData.list.first?.visibility ?? 0
        pressure = Double(currentWeatherData.list.first?.main.pressure ?? 0)
        deg = currentWeatherData.list.first?.wind.deg ?? 0
    }
}
