//
//  HourlyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyForecastCollectionViewCell"
    
    let sectionInserts = UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 9)
    let filter = FiltersData()
    var hourlyWeather: [ForecastWeather] = []
    
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
    
    private let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        setView()
        setConstraint()
        setupCollection()
    }
    
    private func setView() {
        contentView.backgroundColor = #colorLiteral(red: 0.108003743, green: 0.5380584598, blue: 0.7566506267, alpha: 1)
        contentView.alpha = 0.5
        contentView.layer.cornerRadius = 15
    }
    
    private func setupCollection() {
        registerCell()
        setPatterns()
    }
    
    private func registerCell() {
        weatherCollectionView.register(ForecastHoursCollectionViewCell.self, forCellWithReuseIdentifier: ForecastHoursCollectionViewCell.identifier)
    }
    
    private func setPatterns() {
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
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
        
        addSubview(weatherCollectionView)
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        weatherCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherCollectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -40).isActive = true
        weatherCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyForecastCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "squares.below.rectangle")
        title.text = "ПРОГНОЗ ПОГОДЫ НА СЕГОДНЯ"
    }
    
    public func configureForecast(with data: WeatherData) {
        self.hourlyWeather = filter.hourlyForecastFilter(data: data)
        weatherCollectionView.reloadData()
    }
}

extension HourlyForecastCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        switch hourlyWeather[indexPath.row].main {
        case .weather(let data):
            guard let forecastCell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastHoursCollectionViewCell.identifier, for: indexPath) as? ForecastHoursCollectionViewCell else { return UICollectionViewCell() }
            forecastCell.configureCell(from: data)
            cell = forecastCell
        }
        return cell
    }
}

extension HourlyForecastCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
