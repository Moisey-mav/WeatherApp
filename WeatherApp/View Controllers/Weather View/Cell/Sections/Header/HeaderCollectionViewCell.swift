//
//  HeaderCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier  = "HeaderCollectionViewCell"
    
    private let city: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let temp: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .thin)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let typeOfWeather: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let tempLevel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        setView()
        setConstraint()
    }
    
    private func setView() {
        contentView.backgroundColor = .clear
        contentView.alpha = 0.3
        contentView.layer.cornerRadius = 15
    }
    
    private func setConstraint() {
        addSubview(city)
        city.translatesAutoresizingMaskIntoConstraints = false
        city.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        city.topAnchor.constraint(equalTo: topAnchor).isActive = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 5).isActive = true
        temp.centerXAnchor.constraint(equalTo: city.centerXAnchor).isActive = true
        addSubview(typeOfWeather)
        typeOfWeather.translatesAutoresizingMaskIntoConstraints = false
        typeOfWeather.centerXAnchor.constraint(equalTo: temp.centerXAnchor).isActive = true
        typeOfWeather.topAnchor.constraint(equalTo: temp.bottomAnchor, constant: 5).isActive = true
        addSubview(tempLevel)
        tempLevel.translatesAutoresizingMaskIntoConstraints = false
        tempLevel.topAnchor.constraint(equalTo: typeOfWeather.bottomAnchor, constant: 5).isActive = true
        tempLevel.centerXAnchor.constraint(equalTo: typeOfWeather.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderCollectionViewCell {
    
    public func configureForecast(weather: CurrentWeather) {
        city.text = weather.cityName
        temp.text = "\(weather.tempInt)°"
        typeOfWeather.text = weather.description.capitalized
        tempLevel.text = "Макс: \(weather.maxTempInt)°, " + "мин: \(weather.minTempInt)°"
    }
}
