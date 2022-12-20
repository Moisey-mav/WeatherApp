//
//  FooterCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 19.11.2022.
//
import UIKit
import Foundation

class FooterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FooterCollectionViewCell"
    
    weak var viewController: UIViewController?
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .heavy)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let gitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let gitIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.alpha = 0.5
        return imageView
    }()
    
    private let openWeatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.alpha = 0.5
        return imageView
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraint

extension FooterCollectionViewCell {
    private func setConstraint() {
    
        contentView.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        contentView.addSubview(gitLabel)
        gitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gitLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 15),
            gitLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        contentView.addSubview(gitIcon)
        gitIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gitIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gitIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15),
            gitIcon.heightAnchor.constraint(equalToConstant: 20),
            gitIcon.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        contentView.addSubview(openWeatherIcon)
        openWeatherIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openWeatherIcon.centerYAnchor.constraint(equalTo: gitIcon.centerYAnchor),
            openWeatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15),
            openWeatherIcon.heightAnchor.constraint(equalToConstant: 30),
            openWeatherIcon.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - Configure Content

extension FooterCollectionViewCell {
    public func configureContent(with: WeatherData.City) {
        cityLabel.text = "Погода в геопозиции: \(with.name)"
        gitLabel.text = "GitID: Moisey-mav"
        gitIcon.image = UIImage(named: "GithubLogo")
        openWeatherIcon.image = UIImage(named: "OpenWeatherMapLogo")
    }
}  


