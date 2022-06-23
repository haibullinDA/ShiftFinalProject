//
//  CustomTabBarController.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVCs()
        self.setTabBarAppearance()
    }
}

private extension CustomTabBarController {
    
    func setupVCs() {
        let router = Router()
        viewControllers = [
            createNavigationController(for: HomeModuleAssembly.build(router: router),
                                       title: "Home",
                                       image: Assets.homeGrey.image),
            createNavigationController(for: FavoriteModuleAssembly.build(router: router),
                                       title: "Favorite",
                                       image: Assets.favoriteGrey.image),
        ]
    }
    
    func createNavigationController(for rootVC: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.tabBarItem.image = image
        navVC.tabBarItem.title = title
        return navVC
    }
    
    func setTabBarAppearance() {
        let positionX: CGFloat = 44
        let positionY: CGFloat = 14
        
        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 2
        let cgRect = CGRect(x: positionX, y: tabBar.bounds.minY - positionY, width: width, height: height)
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: cgRect,
                                      cornerRadius: height / 2)
        roundLayer.path = bezierPath.cgPath
        roundLayer.fillColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.setShadowTabBar(with: bezierPath.cgPath)
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 2
        tabBar.itemPositioning = .centered
        tabBar.tintColor = Colors.pink.value
        tabBar.unselectedItemTintColor = Colors.tabBarGrey.value
    }
    
    private func setShadowTabBar(with path: CGPath) {
        tabBar.layer.shadowPath = path
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowRadius = 10
    }
}
