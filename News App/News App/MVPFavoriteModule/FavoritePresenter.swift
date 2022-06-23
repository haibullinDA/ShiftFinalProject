//
//  FavoritePresenter.swift
//  News App
//
//  Created by Даниил Хайбуллин on 23.06.2022.
//

import Foundation

protocol IFavoritePresenter {
    func viewDidLoad(view: IFavoriteView, controller: FavoriteViewController)
    func viewWillAppear()
}

final class FavoritePresenter {
    weak var view: IFavoriteView?
    weak var controller: FavoriteViewController?
    
    private let router: Router
    private let dbService: IFavoriteDataBaseService
    
    private var news = [FavoriteModel]()
    private let dataSource: FavoriteDataSource
    
    init(dbService: IFavoriteDataBaseService, router: Router) {
        self.dbService = dbService
        self.router = router
        self.dataSource = FavoriteDataSource(news: self.news)
    }
}

extension FavoritePresenter: IFavoritePresenter {
    func viewDidLoad(view: IFavoriteView, controller: FavoriteViewController) {
        self.view = view
        self.controller = controller
        self.fetchNews()
        self.toNew()
    }
    
    func viewWillAppear() {
        self.fetchNews()
    }
}

private extension FavoritePresenter {
    func toNew() {
        self.view?.cellTapedHandler = { index in
            self.router.routeToNew(with: self.news[index], from: self.controller)
        }
    }
}
private extension FavoritePresenter {
    func displayNews() {
        self.dataSource.setNews(self.news)
        self.view?.setupTableViewDataSource(dataSource: self.dataSource)
    }
    
    func fetchNews() {
        guard let newsMO = self.dbService.fetchNews() else { return }
        self.news = []
        for newMO in newsMO {
            var new = FavoriteModel(newMO: newMO)
            new.imageData = FileManagerService.shared.readImage(withName: newMO.imageName)
            self.news.append(new)
        }
        self.displayNews()
    }
}
