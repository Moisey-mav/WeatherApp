//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "ForecastTableViewCell"
    
    var weather: List.MainClass?
    var dateWeather: List?
    let weatherIcon = WeatherIcon()

    let labelDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    
    private let probabilityLabel: UILabel = {
        let label = UILabel()
        label.text = "tt"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1064303786, green: 0.8684634416, blue: 0.992290318, alpha: 1)
        return label
    }()
    
    private let minTemp: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 0.5
        label.textAlignment = .center
        return label
    }()
    
    private let maxTemp: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = false
        accessoryType = .disclosureIndicator
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weather = nil
        dateWeather = nil
    }
    
    private func setupUI() {
        setupConstraint()
    }
    
    private func setupConstraint() {
        contentView.addSubview(labelDate)
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelDate.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        labelDate.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        contentView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -40).isActive = true
        contentView.addSubview(probabilityLabel)
        probabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        probabilityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        probabilityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contentView.addSubview(minTemp)
        minTemp.translatesAutoresizingMaskIntoConstraints = false
        minTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        minTemp.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 80).isActive = true
        minTemp.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        minTemp.widthAnchor.constraint(equalToConstant: 40).isActive = true
        contentView.addSubview(maxTemp)
        maxTemp.translatesAutoresizingMaskIntoConstraints = false
        maxTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        maxTemp.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        maxTemp.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        maxTemp.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForecastTableViewCell {
    
    public func configureWeather(with: List.MainClass) {
        minTemp.text = "\(Int(with.tempMin))°"
        maxTemp.text = "\(Int(with.tempMax))°"
    }
    
    public func configureDate(with: List) {
        labelDate.text = converter(with: with.dtTxt)
        icon.image = UIImage(systemName: weatherIcon.setImage(index: with.weather.first?.id ?? 0))
        probabilityLabel.text = "\(Int(with.pop * 100)) %"
    }
}

extension ForecastTableViewCell {
    
    private func converter(with date: String) -> String {
        var day = ""
        var mounth = ""
        var year = ""
        let charecters = Array(date)
        for item in charecters.indices {
            if item >= 0 && item <= 3 {
                year += String(charecters[item])
            } else if item >= 5 && item <= 6 {
                mounth += String(charecters[item])
            } else if item >= 8 && item <= 9 {
                day += String(charecters[item])
            }
        }
        let weakday = weekDayConverter(day: day, mounth: mounth, year: year)
        return weakday
    }
    
    private func weekDayConverter(day: String, mounth: String, year: String) -> String {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = Int(day)
        dateComponents.month = Int(mounth)
        dateComponents.year = Int(year)
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEEEEE" // "EEEE"
        
        let currentDate = "\(day).\(mounth).\(year)"
        
        if let date = calendar.date(from: dateComponents)  {
            if currentDate == getCurrentDate() {
                return "Сегодня"
            } else {
                let weakday = dateFormater.string(from: date)
                return weakday.capitalized
            }
        } else {
            return "Error"
        }
    }
    
    private func getCurrentDate() -> String {
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let formatteddate = formatter.string(from: time as Date)
        let currentDate = formatteddate
        return currentDate
    }
}
