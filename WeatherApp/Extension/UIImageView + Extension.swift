//
//  UIImageView + Extension.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 20.12.2022.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat, blurStyle: UIBlurEffect.Style) {
        self.init()
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
