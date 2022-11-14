//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 05.10.2022.
//

import UIKit
import Lottie
import CoreLocation

class WeatherViewController: UIViewController {
    
    let animationView: AnimationView  = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("Сloudy1")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    private var weatherCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let networkWeatherManager = NetworkWeatherManager()
    let location = LocationManager()
    var coordinateLocation: CLLocation?
    let filter = FiltersData()
    var models = [TableSection]()
    var currentForecast: CurrentWeather?
    var hourlyForecast: [ForecastWeather] = []
    var dayForecast: [ForecastWeather] = []
    var sunPosition: WeatherData?
    var airPollution: AirPollution?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        weatherCollection.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        location.setupLocation()
    }
    
    private func setupUI() {
        setupCollection()
        setConstraint()
        settingNavigationBar()
    }
    
    private func settingNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupCollection() {
        weatherCollection.backgroundColor = .clear
        setPatterns()
        registerCell()
        configure()
    }
    
    private func registerCell() {
        weatherCollection.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.identifier)
        weatherCollection.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        weatherCollection.register(DayForecastCollectionViewCell.self, forCellWithReuseIdentifier: DayForecastCollectionViewCell.identifier)
        weatherCollection.register(AirPollutionCollectionViewCell.self, forCellWithReuseIdentifier: AirPollutionCollectionViewCell.identifier)
        weatherCollection.register(FeelsLikeCollectionViewCell.self, forCellWithReuseIdentifier: FeelsLikeCollectionViewCell.identifier)
        weatherCollection.register(VisibilityCollectionViewCell.self, forCellWithReuseIdentifier: VisibilityCollectionViewCell.identifier)
        weatherCollection.register(HumidityCollectionViewCell.self, forCellWithReuseIdentifier: HumidityCollectionViewCell.identifier)
        weatherCollection.register(PrecipitationCollectionViewCell.self, forCellWithReuseIdentifier: PrecipitationCollectionViewCell.identifier)
        weatherCollection.register(WindCollectionViewCell.self, forCellWithReuseIdentifier: WindCollectionViewCell.identifier)
        weatherCollection.register(PressureCollectionViewCell.self, forCellWithReuseIdentifier: PressureCollectionViewCell.identifier)
        weatherCollection.register(SunsetAndSunriseCollectionViewCell.self, forCellWithReuseIdentifier: SunsetAndSunriseCollectionViewCell.identifier)
    }
    
    private func setPatterns() {
        weatherCollection.dataSource = self
        weatherCollection.delegate = self
        networkWeatherManager.delegateWeather = self
        networkWeatherManager.delegateAir = self
        location.locationDelegate = self
    }
    
    private func configure() {
        models.append(TableSection(options: [
            .header, .hourlyForecast, .dayForecast, .airPollution, .sunsetAndSunrise, .wind, .feelsLike, .visibility,
            .humidity, .precipitation, .pressure
        ]))
    }
    
    private func setConstraint() {
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.addSubview(weatherCollection)
    }
}

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        switch model.self {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifier, for: indexPath) as? HeaderCollectionViewCell else { return UICollectionViewCell() }
            if let weather = currentForecast { cell.configureForecast(weather: weather) }
            return cell
        case .hourlyForecast:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as? HourlyForecastCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            cell.configureForecast(array: hourlyForecast)
            return cell
        case .dayForecast:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayForecastCollectionViewCell.identifier, for: indexPath) as? DayForecastCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            cell.configureForecast(array: dayForecast)
            return cell
        case .airPollution:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AirPollutionCollectionViewCell.identifier, for: indexPath) as? AirPollutionCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let pollution = airPollution?.list.first { cell.configureAirPollution(array: pollution) }
            return cell
        case .sunsetAndSunrise:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SunsetAndSunriseCollectionViewCell.identifier, for: indexPath) as? SunsetAndSunriseCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let forecast = sunPosition { cell.configureForecast(with: forecast) }
            return cell
        case .wind:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WindCollectionViewCell.identifier, for: indexPath) as? WindCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weather = currentForecast { cell.configureForecast(weather: weather)}
            return cell
        case .feelsLike:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeelsLikeCollectionViewCell.identifier, for: indexPath) as? FeelsLikeCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weather = currentForecast { cell.configureForecast(weather: weather) }
            return cell
        case .visibility:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisibilityCollectionViewCell.identifier, for: indexPath) as? VisibilityCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weather = currentForecast { cell.configureForecast(weather: weather) }
            return cell
        case .humidity:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumidityCollectionViewCell.identifier, for: indexPath) as? HumidityCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weather = currentForecast { cell.configureForecast(weather: weather) }
            return cell
        case .precipitation:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrecipitationCollectionViewCell.identifier, for: indexPath) as? PrecipitationCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weather = currentForecast { cell.configureForecast(weather: weather) }
            return cell
        case .pressure:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PressureCollectionViewCell.identifier, for: indexPath) as? PressureCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weather = currentForecast { cell.configureForecast(weather: weather)}
            return cell
        }
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCurrentSection = CGSize(width: view.frame.size.width/2.3, height: view.frame.size.width/2.3)
        // CGSize(width: view.frame.size.width/2.3, height: view.frame.size.width/3.5)
        let model = models[indexPath.section].options[indexPath.row]
        switch model.self {
        case .header:
            return CGSize(width: view.frame.size.width - 40, height: view.frame.size.width/2.3)
        case .hourlyForecast:
            return CGSize(width: view.frame.size.width - 40, height: view.frame.size.width/2.3)
        case .dayForecast:
            return CGSize(width: view.frame.size.width - 40, height: view.frame.size.width/1.4)
        case .airPollution:
            return sizeCurrentSection
        case .visibility:
            return sizeCurrentSection
        case .humidity:
            return sizeCurrentSection
        case .precipitation:
            return sizeCurrentSection
        case .wind:
            return sizeCurrentSection
        case .feelsLike:
            return sizeCurrentSection
        case .pressure:
            return sizeCurrentSection
        case .sunsetAndSunrise:
            return sizeCurrentSection
        }
    }
}

extension WeatherViewController: NetworkWeatherManagerDelegate {
    func updateInterface(_: NetworkWeatherManager, with forecast: WeatherData) {
        DispatchQueue.main.async {
            self.hourlyForecast = self.filter.hourlyForecastFilter(data: forecast)
            self.dayForecast = self.filter.dayForecastFilter(data: forecast)
            self.currentForecast = CurrentWeather(currentWeatherData: forecast)
            self.sunPosition = forecast
            self.weatherCollection.reloadData()
        }
    }
}

extension WeatherViewController: NetworkAirManagerDelegate {
    func updateInterface(_: NetworkWeatherManager, with forecast: AirPollution) {
        airPollution = forecast
        DispatchQueue.main.async {
            self.weatherCollection.reloadData()
        }
    }
}

extension WeatherViewController: LocationManagerDelegate {
    func updateInterface(location: CLLocation) {
        DispatchQueue.main.async {
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            self.networkWeatherManager.fetchCurrentWeather(forRequestType: .airPollution(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            self.weatherCollection.reloadData()
        }
    }
}


