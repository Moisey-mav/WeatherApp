//
//  VisibilityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 31.10.2022.
//

import UIKit

class VisibilityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VisibilityCollectionViewCell"
    
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

extension VisibilityCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "eye.fill")
        title.text = "ВИДИМОСТЬ"
    }
    
    public func configureForecast(with data: CurrentWeather) {
        if data.visibility < 1000 {
            contentLabel.text = "\(data.visibility) м"
        } else {
            contentLabel.text = "\(Int(data.visibility / 1000)) км"
        }
    }
}

// MARK: - Setup Constraint

extension VisibilityCollectionViewCell {
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
        
        addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            contentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
        ])
    }
}
