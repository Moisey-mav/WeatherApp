//
//  FiltersData.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 02.11.2022.
//

import Foundation

class FiltersData {
    
    // MARK: - Filter Hourly Forecast
    
    func hourlyForecastFilter(data: WeatherData) -> [ForecastWeather]{
        var modernSection: [ForecastWeather] = []
        if let firstDate = data.list.first?.dtTxt {
            let date = filterDay(date: firstDate)
            let nextDay = filterNextDay(date: firstDate)
            for day in data.list {
                if date == filterDay(date: day.dtTxt) {
                    modernSection.append(ForecastWeather(main: .weather(from: day), city: data.city))
                } else if nextDay == filterDay(date: day.dtTxt) {
                    modernSection.append(ForecastWeather(main: .weather(from: day), city: data.city))
                }
            }
        }
        print(modernSection)
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
        for day in data.list {
            if date != filterDay(date: day.dtTxt) && modernSection.count != 5 {
                modernSection.append(ForecastWeather(main: .weather(from: day), city: data.city))
                date = filterDay(date: day.dtTxt)
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
