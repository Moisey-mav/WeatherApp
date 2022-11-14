//
//  DayForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class DayForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DayForecastCollectionViewCell"
    
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
    
    private let forecastTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    var dayForecast: [ForecastWeather] = []
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        setView()
        setConstraint()
        setTableView()
    }
    
    private func setView() {
        contentView.backgroundColor = #colorLiteral(red: 0.108003743, green: 0.5380584598, blue: 0.7566506267, alpha: 1)
        contentView.alpha = 0.5
        contentView.layer.cornerRadius = 15
    }
    
    private func setTableView() {
        registerCell()
        setPatterns()
    }
    
    private func registerCell() {
        forecastTable.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.identifier)
    }
    
    private func setPatterns() {
        forecastTable.dataSource = self
        forecastTable.delegate = self
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
        
        addSubview(forecastTable)
        forecastTable.translatesAutoresizingMaskIntoConstraints = false
        forecastTable.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        forecastTable.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        forecastTable.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        forecastTable.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DayForecastCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "calendar")
        title.text = "ПРОГНОЗ ПОГОДЫ НА 5 ДН"
    }
    
    public func configureForecast(array: [ForecastWeather]) {
        self.dayForecast = array
        forecastTable.reloadData()
    }
}

extension DayForecastCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayForecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch dayForecast[indexPath.row].mainWeather {
        case .weather(let weather):
            guard let forecastCell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
            if indexPath.row == 0 {
                forecastCell.labelDate.font = .systemFont(ofSize: 15, weight: .bold)
            }
            forecastCell.configureDate(with: weather)
            forecastCell.configureWeather(with: weather.main)
            cell = forecastCell
        }
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.zero
        cell.backgroundColor = .clear
        return cell
    }
}

extension DayForecastCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

