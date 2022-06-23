//
//  Router.swift
//  News App
//
//  Created by Даниил Хайбуллин on 23.06.2022.
//

import Foundation
import UIKit

final class Router {
    func routeToNew<Model>(with model: Model, from controller: UIViewController?) {
        guard let vc = controller else { return }
        let detailController = DetailModuleAssembly.build(model: model)
        vc.navigationController?.pushViewController(detailController, animated: true)
    }
}
