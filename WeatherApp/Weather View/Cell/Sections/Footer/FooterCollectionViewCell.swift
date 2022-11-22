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
    private let networkWeatherManager = NetworkWeatherManager()
    var delegate: AlertControllerDelegate?
    
    private let footerTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.separatorColor = .white
        tableView.isScrollEnabled = false
        return tableView
    }()
    
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
        setTableView()
    }
    
    private func setView() {
        contentView.backgroundColor = .clear
    }
    
    private func setTableView() {
        registerCell()
        setPatterns()
    }
    
    private func registerCell() {
        footerTable.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func setPatterns() {
        footerTable.dataSource = self
        footerTable.delegate = self
    }
    
    private func setConstraint() {
        contentView.addSubview(footerTable)
        footerTable.translatesAutoresizingMaskIntoConstraints = false
        footerTable.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        footerTable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        footerTable.heightAnchor.constraint(equalToConstant: 40).isActive = true
        footerTable.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -26).isActive = true
        
        contentView.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.topAnchor.constraint(equalTo: footerTable.bottomAnchor, constant: 15).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(gitLabel)
        gitLabel.translatesAutoresizingMaskIntoConstraints = false
        gitLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10).isActive = true
        gitLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(gitIcon)
        gitIcon.translatesAutoresizingMaskIntoConstraints = false
        gitIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        gitIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -15).isActive = true
        gitIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        gitIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        contentView.addSubview(openWeatherIcon)
        openWeatherIcon.translatesAutoresizingMaskIntoConstraints = false
        openWeatherIcon.centerYAnchor.constraint(equalTo: gitIcon.centerYAnchor).isActive = true
        openWeatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 15).isActive = true
        openWeatherIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        openWeatherIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FooterCollectionViewCell {
    public func configureContent(with: WeatherData.City) {
        cityLabel.text = "Погода в геопозиции: \(with.name)"
        gitLabel.text = "GitID: Moisey-mav"
        gitIcon.image = UIImage(named: "GithubLogo")
        openWeatherIcon.image = UIImage(named: "OpenWeatherMapLogo")
    }
}

extension FooterCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        footerTable.separatorStyle = .singleLine
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.separatorInset = .zero
        return cell
    }
}

extension FooterCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { [weak self] cityName in
            self?.networkWeatherManager.fetchCurrentWeather(forRequestType: .cityName(city: cityName))
           
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell {
            UIView.animate(withDuration: 0.5) {
                cell.alpha = 0.5
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell {
            UIView.animate(withDuration: 0.2) {
                cell.alpha = 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension FooterCollectionViewCell {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style, completionHandler: @escaping(String) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addTextField { textField in
            let cities = ["Moscow", "New York", "Stambul", "Viena", "Rome"]
            textField.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                print("Search info for the \(cityName)")
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(search)
        alertController.addAction(cancel)
        viewController?.present(alertController, animated: true)
    }
}
