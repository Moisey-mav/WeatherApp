//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 13.10.2022.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func updateInterface(location: CLLocation)
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()

    public weak var locationDelegate: LocationManagerDelegate?
    var networkWeatherManager = NetworkWeatherManager()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else { return }
        self.locationDelegate?.updateInterface(location: currentLocation)
    }
}
