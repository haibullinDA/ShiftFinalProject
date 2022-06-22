//
//  DetailModuleAssembly.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import UIKit

final class DetailModuleAssembly {
    class func build(homeModel: HomeModel) -> UIViewController {
        let dbService = DataBaseService()
        let presenter = DetailPresenter(dbService: dbService, homeModel: homeModel)
        return DetailViewController(presenter: presenter)
    }
}
