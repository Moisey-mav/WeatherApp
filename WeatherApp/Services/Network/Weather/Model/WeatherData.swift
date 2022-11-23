//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 13.10.2022.
//

import Foundation


struct WeatherData: Codable {
    let list: [List]
    let city: City
}

// MARK: - List
struct List: Codable {
    let main: MainClass
    let weather: [Weather]
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case main, weather, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
extension List {
    struct MainClass: Codable, Hashable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure, humidity
        }
    }
    
    // MARK: - Weather
    struct Weather: Codable {
        let id: Int
        let main, description, icon: String
    }
    
    // MARK: - Wind
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    // MARK: - Rain
    struct Rain: Codable {
        let the3H: Double
        
        enum CodingKeys: String, CodingKey {
                case the3H = "3h"
            }
    }
    
    // MARK: - Sys
    struct Sys: Codable {
        let pod: String
    }
}

extension WeatherData {
    // MARK: - City
    struct City: Codable {
        let name: String
        let coord: Coord
        let timezone: Int
        let sunrise: Int
        let sunset: Int
    }
    
    struct Coord: Codable {
        let lat: Double
        let lon: Double
    }
}

















