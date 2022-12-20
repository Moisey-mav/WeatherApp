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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Configure Forecast

extension HeaderCollectionViewCell {
    public func configureForecast(with data: CurrentWeather) {
        city.text = data.cityName
        temp.text = "\(data.tempInt)°"
        typeOfWeather.text = data.description.capitalized
        tempLevel.text = "Макс: \(data.maxTempInt)°, " + "мин: \(data.minTempInt)°"
    }
}

// MARK: - SetupConstraint

extension HeaderCollectionViewCell {
    private func setConstraint() {
        addSubview(city)
        city.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            city.centerXAnchor.constraint(equalTo: centerXAnchor),
            city.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temp.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 5),
            temp.centerXAnchor.constraint(equalTo: city.centerXAnchor)
        ])
        
        addSubview(typeOfWeather)
        typeOfWeather.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeOfWeather.centerXAnchor.constraint(equalTo: temp.centerXAnchor),
            typeOfWeather.topAnchor.constraint(equalTo: temp.bottomAnchor, constant: 5)
        ])
        
        addSubview(tempLevel)
        tempLevel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempLevel.topAnchor.constraint(equalTo: typeOfWeather.bottomAnchor, constant: 5),
            tempLevel.centerXAnchor.constraint(equalTo: typeOfWeather.centerXAnchor)
        ])
        
    }
}
