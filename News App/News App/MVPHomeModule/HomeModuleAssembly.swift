//
//  HomeModuleBuilder.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation
import UIKit

final class HomeModuleAssembly {
    class func build(router: Router) -> UIViewController {
        let networkService = NetworkService()
        let presenter = HomePresenter(router: router, networkService: networkService)
        return HomeViewController(presenter: presenter)
    }
}
