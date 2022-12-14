//
//  DayForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 07.10.2022.
//

import UIKit

class DayForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DayForecastCollectionViewCell"
    
    private var dayForecast: [ForecastWeather] = []
    
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Constraint

extension DayForecastCollectionViewCell {
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
       
        addSubview(forecastTable)
        forecastTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastTable.centerYAnchor.constraint(equalTo: centerYAnchor),
            forecastTable.centerXAnchor.constraint(equalTo: centerXAnchor),
            forecastTable.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            forecastTable.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 5)
        ])
    }
}

// MARK: - Configure Tittle/Forecast

extension DayForecastCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "calendar")
        title.text = "ПРОГНОЗ ПОГОДЫ НА 5 ДН"
    }
    
    public func configureForecast(with data: WeatherData) {
        self.dayForecast = FiltersData.shared.dayForecastFilter(data: data)
        forecastTable.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension DayForecastCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayForecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch dayForecast[indexPath.row].main {
        case .weather(let data):
            guard let forecastCell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
            if indexPath.row == 0 {
                forecastCell.labelDate.font = .systemFont(ofSize: 15, weight: .bold)
            }
            forecastCell.configureCell(with: data)
            cell = forecastCell
        }
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets.zero
        cell.backgroundColor = .clear
        return cell
    }
}

// MARK: - UITableViewDelegate

extension DayForecastCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

