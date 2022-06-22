//
//  HomeRouter.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation

protocol IHomeRouter {
    func routeToNew(with homeModel: HomeModel, from controller: HomeViewController?)
}

final class HomeRouter: IHomeRouter {
    func routeToNew(with homeModel: HomeModel, from controller: HomeViewController?) {
        guard let vc = controller else { return }
        let detailController = DetailModuleAssembly.build(homeModel: homeModel)
        vc.navigationController?.pushViewController(detailController, animated: true)
    }
}
