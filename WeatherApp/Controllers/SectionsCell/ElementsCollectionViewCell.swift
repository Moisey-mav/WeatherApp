//
//  ElementsCollectionViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 08.11.2022.
//

import UIKit

class ElementsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ElementsCollectionViewCell"
    
    private let nameElement: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let indexElement: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gauge.low")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .clear
        setupUI()
    }
    
    private func setupUI() {
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Cell

extension ElementsCollectionViewCell {
  
    public func configure(name: String, iconIndex: String, indexColor: UIColor) {
        nameElement.text = name
        indexElement.image = UIImage(systemName: iconIndex)
        indexElement.tintColor = indexColor
    }
}

// MARK: - Setup Constraint

extension ElementsCollectionViewCell {
    private func setConstraint() {
        contentView.addSubview(nameElement)
        nameElement.translatesAutoresizingMaskIntoConstraints = false
        nameElement.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        nameElement.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

        contentView.addSubview(indexElement)
        indexElement.translatesAutoresizingMaskIntoConstraints = false
        indexElement.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        indexElement.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
