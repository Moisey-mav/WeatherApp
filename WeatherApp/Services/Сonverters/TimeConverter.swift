//
//  TimeConverter.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 19.11.2022.
//

import Foundation

class TimeConverter {
    
    static let shared = TimeConverter()
    
    func unixTime(time: Int, zone: Int) -> String {
        if time == 0 { return "Error Time"}
            let date = NSDate(timeIntervalSince1970: TimeInterval(time))
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "HH:mm"
            dayTimePeriodFormatter.timeZone = NSTimeZone(name: String(zone)) as TimeZone?
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    func converterDayForecast(with date: String) -> String {
        var day = ""
        var mounth = ""
        var year = ""
        let charecters = Array(date)
        for item in charecters.indices {
            if item >= 0 && item <= 3 {
                year += String(charecters[item])
            } else if item >= 5 && item <= 6 {
                mounth += String(charecters[item])
            } else if item >= 8 && item <= 9 {
                day += String(charecters[item])
            }
        }
        let weakday = weekDayConverter(day: day, mounth: mounth, year: year)
        return weakday
    }
    
    private func weekDayConverter(day: String, mounth: String, year: String) -> String {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = Int(day)
        dateComponents.month = Int(mounth)
        dateComponents.year = Int(year)
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEEEEE" // "EEEE"
        
        let currentDate = "\(day).\(mounth).\(year)"
        
        if let date = calendar.date(from: dateComponents)  {
            if currentDate == getCurrentDate() {
                return "Сегодня"
            } else {
                let weakday = dateFormater.string(from: date)
                return weakday.capitalized
            }
        } else {
            return "Error"
        }
    }
    
    private func getCurrentDate() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let formatteddate = formatter.string(from: time as Date)
        let currentDate = formatteddate
        return currentDate
    }
    
}

