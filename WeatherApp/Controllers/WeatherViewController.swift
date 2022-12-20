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
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    let animationView: AnimationView  = {
        let animationView = AnimationView()
        animationView.animation = Animation.named("Clear_D")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    private var weatherCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    var tableModel = [WeatherTableSection]()
    var currentWeatherData: CurrentWeather?
    var weatherData: WeatherData?
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
        LocationManager.shared.setupLocation()
    }
    
    private func setupUI() {
        view.backgroundColor = .gray
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
        configureSections()
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
        weatherCollection.register(FooterCollectionViewCell.self, forCellWithReuseIdentifier: FooterCollectionViewCell.identifier)
    }
    
    private func setPatterns() {
        weatherCollection.dataSource = self
        weatherCollection.delegate = self
        NetworkWeatherManager.shared.delegateWeather = self
        LocationManager.shared.locationDelegate = self
    }
    
    private func configureSections() {
        tableModel.append(WeatherTableSection(sections: [
            .header, .hourlyForecast, .dayForecast, .airPollution, .sunsetAndSunrise, .wind, .feelsLike, .visibility,
            .humidity, .precipitation, .pressure, .footer
        ]))
    }
    
    private func setupAnimations() {
        
    }
}

// MARK: - Setup Constraints

extension WeatherViewController {
    private func setConstraint() {
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        animationView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(weatherCollection)
        weatherCollection.bringSubviewToFront(animationView)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableModel[section].sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = tableModel[indexPath.section].sections[indexPath.row]
        switch model.self {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifier, for: indexPath) as? HeaderCollectionViewCell else { return UICollectionViewCell() }
            if let weatherData = currentWeatherData { cell.configureForecast(with: weatherData) }
            return cell
        case .hourlyForecast:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as? HourlyForecastCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = weatherData { cell.configureForecast(with: weatherData) }
            return cell
        case .dayForecast:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayForecastCollectionViewCell.identifier, for: indexPath) as? DayForecastCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = weatherData { cell.configureForecast(with: weatherData) }
            return cell
        case .airPollution:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AirPollutionCollectionViewCell.identifier, for: indexPath) as? AirPollutionCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let pollution = airPollution?.list.first { cell.configureAirPollution(with: pollution) }
            return cell
        case .sunsetAndSunrise:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SunsetAndSunriseCollectionViewCell.identifier, for: indexPath) as? SunsetAndSunriseCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = weatherData { cell.configureForecast(with: weatherData) }
            return cell
        case .wind:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WindCollectionViewCell.identifier, for: indexPath) as? WindCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = currentWeatherData { cell.configureForecast(with: weatherData)}
            return cell
        case .feelsLike:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeelsLikeCollectionViewCell.identifier, for: indexPath) as? FeelsLikeCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = currentWeatherData { cell.configureForecast(with: weatherData) }
            return cell
        case .visibility:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VisibilityCollectionViewCell.identifier, for: indexPath) as? VisibilityCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = currentWeatherData { cell.configureForecast(with: weatherData) }
            return cell
        case .humidity:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumidityCollectionViewCell.identifier, for: indexPath) as? HumidityCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = currentWeatherData { cell.configureForecast(with: weatherData) }
            return cell
        case .precipitation:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrecipitationCollectionViewCell.identifier, for: indexPath) as? PrecipitationCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = currentWeatherData { cell.configureForecast(with: weatherData) }
            return cell
        case .pressure:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PressureCollectionViewCell.identifier, for: indexPath) as? PressureCollectionViewCell else { return UICollectionViewCell() }
            cell.configureTitle()
            if let weatherData = currentWeatherData { cell.configureForecast(with: weatherData)}
            return cell
        case .footer:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FooterCollectionViewCell.identifier, for: indexPath) as? FooterCollectionViewCell else { return UICollectionViewCell() }
            if let weatherData = weatherData?.city { cell.configureContent(with: weatherData) }
            cell.viewController = self
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCurrentSection = CGSize(width: view.frame.size.width/2.3, height: view.frame.size.width/2.3)
        let model = tableModel[indexPath.section].sections[indexPath.row]
        switch model.self {
        case .header:
            return CGSize(width: view.frame.size.width - 30, height: view.frame.size.width/2.3)
        case .hourlyForecast:
            return CGSize(width: view.frame.size.width - 30, height: view.frame.size.width/2.3)
        case .dayForecast:
            return CGSize(width: view.frame.size.width - 30, height: view.frame.size.width/1.5)
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
        case .footer:
            return CGSize(width: view.frame.size.width - 30, height: view.frame.size.width/3.4)
        }
    }
}

// MARK: - LocationManagerDelegate

extension WeatherViewController: LocationManagerDelegate {
    func updateInterface(location: CLLocation) {
        DispatchQueue.main.async {
            NetworkWeatherManager.shared.fetchCurrentWeather(forRequestType: .coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            self.weatherCollection.reloadData()
        }
    }
}

// MARK: - NetworkWeatherManagerDelegate

extension WeatherViewController: NetworkWeatherManagerDelegate {
    func updateWeatherForecast(_: NetworkWeatherManager, with forecast: WeatherData) {
        DispatchQueue.main.async {
            self.weatherData = forecast
            self.currentWeatherData = CurrentWeather(currentWeatherData: forecast)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
//            self.setupAnimations(forecast: forecast)
            self.weatherCollection.reloadData()
        }
    }
    
    func updateAirPollution(_: NetworkWeatherManager, with forecast: AirPollution) {
        airPollution = forecast
        DispatchQueue.main.async {
            self.weatherCollection.reloadData()
        }
    }
    
    func setupAnimations(forecast: WeatherData) {
        let idexWeather = forecast.list.first?.weather.first?.id ?? 0
        let podWeather = forecast.list.first?.sys.pod ?? "defolt"
        animationView.animation = Animation.named(WeatherAnimations.shared.setAnimations(index: idexWeather, pod: podWeather))
        animationView.play()
    }
}


