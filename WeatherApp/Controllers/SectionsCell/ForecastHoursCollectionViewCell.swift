//
//  ForecastHoursCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class ForecastHoursCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ForecastHoursCollectionViewCell"
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.text = "20"
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
    
    private let temperature: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "17 °"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .clear
        setupUI()
    }
    
    private func setupUI() {
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Tittle/Forecast

extension ForecastHoursCollectionViewCell {
    
    public func configureCell(from data: List, podIndex: String) {
        title.text = сonverter(with: data.dtTxt)
        icon.image = UIImage(systemName: WeatherIcon.shared.setImage(index: data.weather.first?.id ?? 0, pod: podIndex))
        probabilityLabel.text = "\(Int(data.pop * 100)) %"
        temperature.text = "\(Int(data.main.temp))°"
    }
    
    private func сonverter(with date: String) -> String {
        let charecters = Array(date)
        var corectDate = ""
        for item in 11...15 {
            corectDate += String(charecters[item])
        }
        return corectDate
    }
}

// MARK: - Setup Constraint

extension ForecastHoursCollectionViewCell {
    private func setConstraint() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        contentView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10).isActive = true
        icon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(probabilityLabel)
        probabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        probabilityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10).isActive = true
        probabilityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(temperature)
        temperature.translatesAutoresizingMaskIntoConstraints = false
        temperature.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        temperature.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
