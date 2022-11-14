//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 14.10.2022.
//

import Foundation
import CoreLocation

protocol NetworkWeatherManagerDelegate: AnyObject {
    func updateInterface(_: NetworkWeatherManager, with forecast: WeatherData)
}

protocol NetworkAirManagerDelegate: AnyObject {
    func updateInterface(_:NetworkWeatherManager, with forecast: AirPollution)
}

class NetworkWeatherManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
        case airPollution(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    public weak var delegateWeather: NetworkWeatherManagerDelegate?
    public weak var delegateAir: NetworkAirManagerDelegate?
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        var urlAirString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://ru.api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=Metric&lang=ru"
        case .coordinate(let latitude, let longitude):
            urlString = "https://ru.api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=Metric&lang=ru"
        case .airPollution(let latitude, let longitude):
            urlAirString = "https://ru.api.openweathermap.org/data/2.5/air_pollution?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        }
        performWeatherRequest(withURLString: urlString)
        performAirRequest(withURLString: urlAirString)
    }
    
    fileprivate func performWeatherRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                self.delegateWeather?.updateInterface(self, with: weatherData)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    fileprivate func performAirRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let airPollutionData = try JSONDecoder().decode(AirPollution.self, from: data)
                self.delegateAir?.updateInterface(self, with: airPollutionData)
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
}
