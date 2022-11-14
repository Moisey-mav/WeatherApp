//
//  TabBarViewController.swift
//  WeatherApp
//
//  Created by Владислав Моисеев on 05.10.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let animation = WeatherViewController()
    
    private let search: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateCustomTabBar()
        setConstraint()
    }
    
    private func generateCustomTabBar() {
        generateItems()
        settingsTabBar()
    }
    
    private func generateItems() {
        let weather = UINavigationController(rootViewController: WeatherViewController())
        viewControllers = [
            generateVC(viewController: weather, image: UIImage(systemName: "cloud"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func settingsTabBar() {
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = #colorLiteral(red: 0.2235252261, green: 0.5800338984, blue: 0.760234952, alpha: 1)
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.isTranslucent = true
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.simleAnimationWhenSelectetItem(item)
    }
    
    private func simleAnimationWhenSelectetItem(_ item: UITabBarItem) {
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        let itemInterval: TimeInterval = 0.3
        let propertyAnimation = UIViewPropertyAnimator(duration: itemInterval, dampingRatio: 0.5) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }
        propertyAnimation.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(itemInterval))
        propertyAnimation.startAnimation()
    }
    
    private func setupButton() {
        
    }

    private func setConstraint() {
        tabBar.addSubview(search)
        search.translatesAutoresizingMaskIntoConstraints = false
        search.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 5).isActive = true
        search.rightAnchor.constraint(equalTo: tabBar.rightAnchor, constant: -30).isActive = true
        search.heightAnchor.constraint(equalToConstant: 25).isActive = true
        search.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }

}
