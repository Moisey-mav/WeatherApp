//
//  WindCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class WindCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WindCollectionViewCell"
    
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
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    private let compass: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Compass")
        return imageView
    }()
    
    private let compassArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "CompassArrow")
        return imageView
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Tittle/Forecast

extension WindCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "wind")
        title.text = "ВЕТЕР"
    }
    
    public func configureForecast(with data: CurrentWeather) {
        contentLabel.text = "\(data.windSpeedInt)" + "\n" + "м/с"
        compassArrow.transform = compassArrow.transform.rotated(by: CGFloat(data.degConvert))
    }
}

// MARK: - Setup Constraint

extension WindCollectionViewCell {
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
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 7),
            contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
      
        
        contentView.addSubview(compass)
        compass.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compass.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            compass.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            compass.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            compass.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
        
        addSubview(compassArrow)
        compassArrow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compassArrow.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            compassArrow.centerXAnchor.constraint(equalTo: centerXAnchor),
            compassArrow.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            compassArrow.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}
