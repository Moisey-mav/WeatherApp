//
//  AirPollutionIndex.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 08.11.2022.
//

import UIKit

class AirPollutionIndex {
    
    func setAirIndex(with: Int) -> ( airIndex: String, iconColor: UIColor) {
        switch with {
        case 1: return ("Хороший", #colorLiteral(red: 0, green: 0.8372161984, blue: 0, alpha: 1))
        case 2: return ("Удовлетворительный", #colorLiteral(red: 0.7745178938, green: 0.8244408965, blue: 0, alpha: 1))
        case 3: return ("Умеренный", #colorLiteral(red: 1, green: 0.6453468204, blue: 0, alpha: 1))
        case 4: return ("Плохой", #colorLiteral(red: 0.8906189799, green: 0.2743590474, blue: 0.1751044691, alpha: 1))
        case 5: return ("Очень плохой", #colorLiteral(red: 0.7691341043, green: 0, blue: 0.2554246783, alpha: 1))
        default:
            return ("Нет данных", .white)
        }
    }
    
    func ozonIndex(with: Double) -> (iconName: String, iconColor: UIColor) {
        switch with {
        case 0...40: return ("gauge.low", #colorLiteral(red: 0, green: 0.8372161984, blue: 0, alpha: 1))
        case 41...80:  return ( "gauge.medium", #colorLiteral(red: 0.7745178938, green: 0.8244408965, blue: 0, alpha: 1))
        case 81...120:  return ( "gauge.medium", #colorLiteral(red: 1, green: 0.6453468204, blue: 0, alpha: 1))
        case 121...160: return ( "gauge.high", #colorLiteral(red: 0.8906189799, green: 0.2743590474, blue: 0.1751044691, alpha: 1))
        default:
            return (iconName: "gauge.high", iconColor: #colorLiteral(red: 0.7691341043, green: 0, blue: 0.2554246783, alpha: 1))
        }
    }
    
    func nitrogenOxideIndex(with: Double) -> (iconName: String, iconColor: UIColor) {
        switch with {
        case 0...21: return ("gauge.low", #colorLiteral(red: 0, green: 0.8372161984, blue: 0, alpha: 1))
        case 22...43:  return ( "gauge.medium", #colorLiteral(red: 0.7745178938, green: 0.8244408965, blue: 0, alpha: 1))
        case 44...65:  return ( "gauge.medium", #colorLiteral(red: 1, green: 0.6453468204, blue: 0, alpha: 1))
        case 66...85: return ( "gauge.high", #colorLiteral(red: 0.8906189799, green: 0.2743590474, blue: 0.1751044691, alpha: 1))
        default:
            return (iconName: "gauge.high", iconColor: #colorLiteral(red: 0.7691341043, green: 0, blue: 0.2554246783, alpha: 1))
        }
    }
    
    func oxideSoonIndex(with: Double) -> (iconName: String, iconColor: UIColor) {
        switch with {
        case 0...225: return ("gauge.low", #colorLiteral(red: 0, green: 0.8372161984, blue: 0, alpha: 1))
        case 226...450:  return ( "gauge.medium", #colorLiteral(red: 0.7745178938, green: 0.8244408965, blue: 0, alpha: 1))
        case 451...675:  return ( "gauge.medium", #colorLiteral(red: 1, green: 0.6453468204, blue: 0, alpha: 1))
        case 676...900: return ( "gauge.high", #colorLiteral(red: 0.8906189799, green: 0.2743590474, blue: 0.1751044691, alpha: 1))
        default:
            return (iconName: "gauge.high", iconColor: #colorLiteral(red: 0.7691341043, green: 0, blue: 0.2554246783, alpha: 1))
        }
    }
    
    func coarseSubstanceIndex(with: Double) -> (iconName: String, iconColor: UIColor) {
        switch with {
        case 0...20: return ("gauge.low", #colorLiteral(red: 0, green: 0.8372161984, blue: 0, alpha: 1))
        case 21...25:  return ( "gauge.medium", #colorLiteral(red: 0.7745178938, green: 0.8244408965, blue: 0, alpha: 1))
        case 26...50:  return ( "gauge.medium", #colorLiteral(red: 1, green: 0.6453468204, blue: 0, alpha: 1))
        case 51...75: return ( "gauge.high", #colorLiteral(red: 0.8906189799, green: 0.2743590474, blue: 0.1751044691, alpha: 1))
        default:
            return (iconName: "gauge.high", iconColor: #colorLiteral(red: 0.7691341043, green: 0, blue: 0.2554246783, alpha: 1))
        }
    }
}
