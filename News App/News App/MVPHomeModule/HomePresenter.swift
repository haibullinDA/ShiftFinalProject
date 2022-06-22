//
//  HomePresenter.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation

protocol IHomePresenter: AnyObject {
    func viewDidLoad(view: IHomeView, controller: HomeViewController)
}

final class HomePresenter {
    weak var view: IHomeView?
    weak var controller: HomeViewController?
    
    private let router: IHomeRouter
    private let networkService: INetworkService
    
    private var news = [HomeModel]()
    private let dataSource: HomeDataSource
    private var nextPage: Int?
    
    init(router: IHomeRouter, networkService: INetworkService) {
        self.router = router
        self.networkService = networkService
        self.dataSource = HomeDataSource(news: self.news)
        NotificationCenter.default.addObserver(self, selector: #selector(categoryNews(_:)), name: .setCategory, object: nil)
    }
    
    @objc
    private func categoryNews(_ notification: NSNotification) {
        guard let category = notification.userInfo?[String(describing: Category.self)] as? String else { return }
        if category == Category.all.rawValue {
            self.networkService.addParam(NetworkService.Param.category.rawValue, for: nil)
            self.networkService.addParam(NetworkService.Param.page.rawValue, for: nil)
        } else {
            self.networkService.addParam(NetworkService.Param.category.rawValue, for: category.lowercased())
            self.networkService.addParam(NetworkService.Param.page.rawValue, for: nil)
        }
        self.loadStartNews()
    }
}

extension HomePresenter: IHomePresenter {
    func viewDidLoad(view: IHomeView, controller: HomeViewController) {
        self.view = view
        self.controller = controller
        self.loadStartNews()
        self.loadHandler()
        self.searchHandler()
        self.toNew()
    }
}
private extension HomePresenter {
    func toNew() {
        self.view?.cellTapedHandler = { index in
            self.router.routeToNew(with: self.news[index], from: self.controller)
        }
    }
}

private extension HomePresenter {
    
    func displayNews() {
        self.dataSource.setNews(self.news)
        self.view?.setupTableViewDataSource(dataSource: self.dataSource)
    }
    
    func loadStartNews() {
        if self.news.isEmpty == false {
            self.news = []
        }
        self.loadNews()
    }
    
    func loadMoreNews() {
        if let nextPage = self.nextPage {
            self.networkService.addParam(NetworkService.Param.page.rawValue, for: String(nextPage))
            self.loadNews()
        }
    }
    
    private func loadHandler() {
        self.dataSource.loadHandler = {
            self.loadMoreNews()
        }
    }
    
    private func searchHandler() {
        self.view?.searchHandler = { text in
            if text == "" {
                self.networkService.addParam(NetworkService.Param.q.rawValue, for: nil)
            } else {
                self.networkService.addParam(NetworkService.Param.q.rawValue, for: text)
            }
            self.loadStartNews()
        }
    }
    
    func loadNews() {
        self.networkService.loadNews { (result: Result<NewsDTO, Error>) in
            switch result {
            case .success(let newsDTO):
                DispatchQueue.main.async {
                    for new in newsDTO.results {
                        self.nextPage = newsDTO.nextPage
                        let model = HomeModel(with: new)
                        self.news.append(model)
                        if let urlString = new.imageURL {
                            self.loadImage(from: urlString, for: model)
                        } else {
                            self.displayNews()
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    func loadImage(from urlString: String, for new: HomeModel) {
        self.networkService.loadImage(urlString: urlString) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    new.image = data
                    self.displayNews()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}
