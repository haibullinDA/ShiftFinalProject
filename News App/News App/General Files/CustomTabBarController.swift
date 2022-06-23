//
//  CustomTabBarController.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    private enum Constant {
        static let positionX: CGFloat = 44
        static let positionY: CGFloat = 14
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 10
    }
    
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

        let width = tabBar.bounds.width - Constant.positionX * 2
        let height = tabBar.bounds.height + Constant.positionY * 2
        let cgRect = CGRect(x: Constant.positionX, y: tabBar.bounds.minY - Constant.positionY, width: width, height: height)
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: cgRect,
                                      cornerRadius: height / 2)
        roundLayer.path = bezierPath.cgPath
        roundLayer.fillColor = Colors.white.value.cgColor
        self.setShadowTabBar(with: bezierPath.cgPath)
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 2
        tabBar.itemPositioning = .centered
        tabBar.tintColor = Colors.pink.value
        tabBar.unselectedItemTintColor = Colors.tabBarGrey.value
    }
    
    private func setShadowTabBar(with path: CGPath) {
        tabBar.layer.shadowPath = path
        tabBar.layer.shadowColor = Colors.blackHalf.value.cgColor
        tabBar.layer.shadowOpacity = Constant.shadowOpacity
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowRadius = Constant.shadowRadius
    }
}
