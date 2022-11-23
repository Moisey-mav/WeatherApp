//
//  WeatherIcon.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 08.11.2022.
//

import Foundation

class WeatherIcon {
    
    public func setImage(index: Int, pod: String) -> String {
        switch index {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...302: return "cloud.drizzle.fill"
        case 310...312: return "cloud.rain.fill"
        case 313...321: return "cloud.heavyrain.fill"
        case 500...531: if pod == "d" { return "cloud.sun.rain.fill" }
            else { return "cloud.moon.rain.fill" }
        case 600...601: return "snowflake"
        case 602: return "cloud.snow.fill"
        case 611...622: return "cloud.sleet.fill"
        case 701...741: if pod == "d" { return "sun.haze.fill" }
            else { return "moon.haze.fill" }
        case 751...771: return "sun.dust.fill"
        case 781: return "tornado"
        case 800: if pod == "d" { return "sun.max.fill" }
            else { return "moon.fill" }
        case 801: if pod == "d" { return "cloud.sun.fill" }
            else { return "cloud.moon.fill" }
        case 802...804: return "cloud.fill"
        default: return "nosign"
        }
    }
}
