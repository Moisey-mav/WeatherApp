//
//  AirPollution.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 02.11.2022.
//

import Foundation

struct AirPollution: Codable {
    let list: [ListAir]
}

struct ListAir: Codable {
    let main: MainAqi
    let components: [String: Double]
}

struct MainAqi: Codable {
    let aqi: Int
}
