//
//  FiltersData.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 02.11.2022.
//

import UIKit

class FiltersData {
    
    // MARK: - Filter Hourly Forecast
    
    func hourlyForecastFilter(data: WeatherData) -> [ForecastWeather]{
        var modernSection: [ForecastWeather] = []
        if let firstDate = data.list.first?.dtTxt {
            let date = filterDay(date: firstDate)
            let nextDay = filterNextDay(date: firstDate)
            for weather in data.list {
                if date == filterDay(date: weather.dtTxt) {
                    modernSection.append(ForecastWeather(mainWeather: .weather(weather: weather), dateWeather: .dateWeather(date: weather)))
                } else if nextDay == filterDay(date: weather.dtTxt) {
                    modernSection.append(ForecastWeather(mainWeather: .weather(weather: weather), dateWeather: .dateWeather(date: weather)))
                }
            }
        }
        return modernSection
    }
    
    private func filterNextDay(date: String) -> String {
        let charecters = Array(date)
        let filteredDate = String((Int(String(charecters[8]) + String(charecters[9])) ?? 0) + 1)
        return filteredDate
    }
    
    // MARK: - Filter Day Forecast
    
    func dayForecastFilter(data: WeatherData) -> [ForecastWeather] {
        var modernSection: [ForecastWeather] = []
        var date = ""
        for weather in data.list {
            if date != filterDay(date: weather.dtTxt) && modernSection.count != 5 {
                modernSection.append(ForecastWeather(mainWeather: .weather(weather: weather), dateWeather: .dateWeather(date: weather)))
                date = filterDay(date: weather.dtTxt)
            }
        }
        return modernSection
    }
    
    private func filterDay(date: String) -> String {
        let charecters = Array(date)
        let filteredDate = String(Int(String(charecters[8]) + String(charecters[9])) ?? 0)
        return filteredDate
    }
}
