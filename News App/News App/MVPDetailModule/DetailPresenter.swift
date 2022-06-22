//
//  DetailPresenter.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import Foundation

protocol IDetailPresenter: AnyObject {
    func viewDidLoad(view: IDetailView, controller: DetailViewController)
}

final class DetailPresenter {
    weak var view: IDetailView?
    weak var controller: DetailViewController?
    private let dbService: IDataBaseService
    private let homeModel: HomeModel
    
    init(dbService: IDataBaseService, homeModel: HomeModel) {
        self.dbService = dbService
        self.homeModel = homeModel
    }
}

extension DetailPresenter: IDetailPresenter {
    func viewDidLoad(view: IDetailView, controller: DetailViewController) {
        self.view = view
        self.controller = controller
        self.view?.displayData(.init(with: self.homeModel))
        self.backHandler()
    }
}

private extension DetailPresenter {
    func backHandler() {
        self.view?.backHandler = {
            self.controller?.navigationController?.popViewController(animated: true)
        }
    }
    
}
