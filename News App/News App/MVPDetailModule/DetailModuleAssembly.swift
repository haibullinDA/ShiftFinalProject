//
//  DetailModuleAssembly.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import UIKit

final class DetailModuleAssembly {
    class func build<Model>(model: Model) -> UIViewController {
        let dbService = DataBaseService()
        let presenter = DetailPresenter(dbService: dbService, model: model)
        return DetailViewController(presenter: presenter)
    }
}
