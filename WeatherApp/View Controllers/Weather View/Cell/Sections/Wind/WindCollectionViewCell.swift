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
        contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 7).isActive = true
        contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        contentView.addSubview(compass)
        compass.translatesAutoresizingMaskIntoConstraints = false
        compass.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10).isActive = true
        compass.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        compass.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        compass.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        addSubview(compassArrow)
        compassArrow.translatesAutoresizingMaskIntoConstraints = false
        compassArrow.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        compassArrow.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        compassArrow.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        compassArrow.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WindCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "wind")
        title.text = "ВЕТЕР"
    }
    
    public func configureForecast(weather: CurrentWeather) {
        contentLabel.text = "\(weather.windSpeedInt)" + "\n" + "м/с"
        compassArrow.transform = compassArrow.transform.rotated(by: CGFloat(weather.degConvert))
    }
}
