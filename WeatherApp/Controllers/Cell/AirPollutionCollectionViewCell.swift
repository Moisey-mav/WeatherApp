//
//  AirPollutionCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 02.11.2022.
//

import UIKit

class AirPollutionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AirPollutionCollectionViewCell"
    
    let sectionInserts = UIEdgeInsets(top: 1, left: 4, bottom: 1, right: 9)
    let chemicalElements = ["No","O3","CO","РМ10"]
    var airPollution: ListAir?
    
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
    
    private let iconQualityIndex: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lungs.fill")
        return imageView
    }()
    
    private let qualityIndex: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let elementsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
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
        elementsCollectionView.register(ElementsCollectionViewCell.self, forCellWithReuseIdentifier: ElementsCollectionViewCell.identifier)
    }
    
    private func setPatterns() {
        elementsCollectionView.dataSource = self
        elementsCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Tittle/Forecast

extension AirPollutionCollectionViewCell {
    
    public func configureTitle() {
        icon.image = UIImage(systemName: "carbon.dioxide.cloud.fill")
        title.text = "ВОЗДУХ"
    }
    
    public func configureAirPollution(with: ListAir) {
        self.airPollution = with
        let parametrs = AirPollutionIndex.shared.setAirIndex(with: 1)
        iconQualityIndex.tintColor = parametrs.iconColor
        qualityIndex.text = "Индекс: \n" + parametrs.airIndex
        elementsCollectionView.reloadData()
    }
}

// MARK: - Setup Constraint

extension AirPollutionCollectionViewCell {
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
        
        contentView.addSubview(iconQualityIndex)
        iconQualityIndex.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconQualityIndex.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            iconQualityIndex.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            iconQualityIndex.heightAnchor.constraint(equalToConstant: 50),
            iconQualityIndex.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        addSubview(qualityIndex)
        qualityIndex.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            qualityIndex.centerYAnchor.constraint(equalTo: iconQualityIndex.centerYAnchor),
            qualityIndex.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15)
        ])
        
        addSubview(elementsCollectionView)
        elementsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            elementsCollectionView.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            elementsCollectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            elementsCollectionView.heightAnchor.constraint(equalToConstant: 100),
            elementsCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -22)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension AirPollutionCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chemicalElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementsCollectionViewCell.identifier, for: indexPath) as? ElementsCollectionViewCell else { return UICollectionViewCell() }
       // cell.backgroundColor = .red
        switch chemicalElements[indexPath.row] {
        case "No":
            let forecastCell = cell
            let parametrs = AirPollutionIndex.shared.nitrogenOxideIndex(with: airPollution?.components["no"] ?? 0)
            forecastCell.configure(name: "No", iconIndex: parametrs.iconName, indexColor: parametrs.iconColor)
            return forecastCell
        case "O3":
            let forecastCell = cell
            let parametrs = AirPollutionIndex.shared.ozonIndex(with: airPollution?.components["o3"] ?? 0)
            forecastCell.configure(name: "O3", iconIndex: parametrs.iconName, indexColor: parametrs.iconColor)
            return forecastCell
        case "CO":
            let forecastCell = cell
            let parametrs = AirPollutionIndex.shared.oxideSoonIndex(with: airPollution?.components["co"] ?? 0 )
            forecastCell.configure(name: "CO", iconIndex: parametrs.iconName, indexColor: parametrs.iconColor)
            return forecastCell
        case "РМ10":
            let forecastCell = cell
            let parametrs = AirPollutionIndex.shared.coarseSubstanceIndex(with: airPollution?.components["pm10"] ?? 0 )
            forecastCell.configure(name: "Pm10", iconIndex: parametrs.iconName, indexColor: parametrs.iconColor)
            return forecastCell
        default:
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AirPollutionCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 33, height: 50)
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

