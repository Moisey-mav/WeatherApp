//
//  PressureCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class PressureCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PressureCollectionViewCell"
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = #colorLiteral(red: 0.108003743, green: 0.5380584598, blue: 0.7566506267, alpha: 1)
        contentView.alpha = 0.5
        contentView.layer.cornerRadius = 15
        setConstraint()
    }
    
    private func setConstraint() {
        contentView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5).isActive = true
        
        addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PressureCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "gauge.medium")
        title.text = "ДАВЛЕНИЕ"
    }
    
    public func configureForecast(weather: CurrentWeather) {
        contentLabel.text = "\(weather.pressureСonverted)" + "\n" + "мм. рт. ст."
    }
}
