//
//  SunsetAndSunriseCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 02.11.2022.
//

import UIKit

class SunsetAndSunriseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SunsetAndSunriseCollectionViewCell"
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let timeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let timeIsNow: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 30, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let sunPosition: UILabel = {
        let label = UILabel()
        label.text = "Закат: 00:00"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 20, weight: .regular)
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
        contentView.backgroundColor = #colorLiteral(red: 0.108003743, green: 0.5380584598, blue: 0.7566506267, alpha: 1)
        contentView.alpha = 0.5
        contentView.layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Tittle/Forecast

extension SunsetAndSunriseCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "sunrise.fill")
    }
    
    public func configureForecast(with data: WeatherData) {
        timeIsNow.text = currentTime(zone: data.city.timezone)
        if data.list.first?.sys.pod == "d" {
            title.text = "ЗАКАТ СОЛНЦА"
            icon.image = UIImage(systemName: "sunset.fill")
            timeIcon.image = UIImage(systemName: "sun.max.fill")
            sunPosition.text = "Закат: " + TimeConverter.shared.unixTime(time: data.city.sunset, zone: data.city.timezone)
        } else {
            title.text = "ВОСХОД СОЛНЦА"
            icon.image = UIImage(systemName: "sunrise.fill")
            timeIcon.image = UIImage(systemName: "moon.fill")
            sunPosition.text = "Восход: " + TimeConverter.shared.unixTime(time: data.city.sunrise, zone: data.city.timezone)
        }
    }
}

// MARK: - Setup Constraint

extension SunsetAndSunriseCollectionViewCell {
    private func setConstraint() {
        contentView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15)
        ])
        
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
            title.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5)
        ])
        
        addSubview(timeIcon)
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            timeIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            timeIcon.heightAnchor.constraint(equalToConstant: 55),
            timeIcon.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        addSubview(timeIsNow)
        timeIsNow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeIsNow.centerYAnchor.constraint(equalTo: timeIcon.centerYAnchor),
            timeIsNow.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15)
        ])
        
        addSubview(sunPosition)
        sunPosition.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sunPosition.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            sunPosition.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}

// MARK: - Convert Time

extension SunsetAndSunriseCollectionViewCell {
    
    private func currentTime(zone: Int) -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: zone)
        let formatteddate = formatter.string(from: time as Date)
        return formatteddate
    }
}

