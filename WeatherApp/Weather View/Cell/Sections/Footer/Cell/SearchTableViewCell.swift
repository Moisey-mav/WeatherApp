//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 19.11.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let iconSearch: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let labelSearch: UILabel = {
        let label = UILabel()
        label.text = "Поиск по городу"
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = false
        accessoryType = .disclosureIndicator
        setupUI()
    }
    
    private func setupUI() {
        setupConstraint()
    }
    
    private func setupConstraint() {
        
        contentView.addSubview(labelSearch)
        labelSearch.translatesAutoresizingMaskIntoConstraints = false
        labelSearch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        labelSearch.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(iconSearch)
        iconSearch.translatesAutoresizingMaskIntoConstraints = false
        iconSearch.centerYAnchor.constraint(equalTo: labelSearch.centerYAnchor).isActive = true
        iconSearch.rightAnchor.constraint(equalTo: labelSearch.leftAnchor, constant: -10).isActive = true
        iconSearch.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconSearch.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
