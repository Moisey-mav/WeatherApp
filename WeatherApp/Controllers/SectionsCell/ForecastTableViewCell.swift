//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let identifier = "ForecastTableViewCell"

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
    
    private func setupUI() {
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Cell

extension ForecastTableViewCell {
    
    public func configureCell(with data: List) {
        labelDate.text = TimeConverter.shared.converterDayForecast(with: data.dtTxt)
        icon.image = UIImage(systemName: WeatherIcon.shared.setImage(index: data.weather.first?.id ?? 0, pod: "d"))
        probabilityLabel.text = "\(Int(data.pop * 100)) %"
        minTemp.text = "\(Int(data.main.tempMin))°"
        maxTemp.text = "\(Int(data.main.tempMax))°"
    }
}

// MARK: - Setup Constraint

extension ForecastTableViewCell {
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
}
