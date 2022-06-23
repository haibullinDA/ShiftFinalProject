//
//  FavoriteModuleAssembly.swift
//  News App
//
//  Created by Даниил Хайбуллин on 23.06.2022.
//

import UIKit

final class FavoriteModuleAssembly {
    class func build(router: Router) -> UIViewController {
        let dbService = DataBaseService()
        let presenter = FavoritePresenter(dbService: dbService, router: router)
        return FavoriteViewController(presenter: presenter)
    }
}
