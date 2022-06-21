//
//  SceneDelegate.swift
//  News App
//
//  Created by Даниил Хайбуллин on 20.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = CustomTabBarController()
        self.window?.makeKeyAndVisible()
    }
}

