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
    
    private var news = [Model]()
    private let dataSource: HomeDataSource
    
    private let semaphore = DispatchSemaphore(value: 1)
    
    init(router: IHomeRouter, networkService: INetworkService) {
        self.router = router
        self.networkService = networkService
        self.dataSource = HomeDataSource(news: self.news)
    }
}

extension HomePresenter: IHomePresenter {
    func viewDidLoad(view: IHomeView, controller: HomeViewController) {
        self.view = view
        self.controller = controller
        self.loadNews()
    }
}

private extension HomePresenter {
    func loadNews() {
        if self.news.isEmpty == false {
            self.news = []
        }
        self.networkService.loadNews { (result: Result<NewsDTO, Error>) in
            switch result {
            case .success(let newsDTO):
                DispatchQueue.main.async {
                    for new in newsDTO.results {
                        let model = Model(with: new)
                        self.news.append(model)
                        if let urlString = new.imageURL {
                            self.loadImage(from: urlString, for: model)
                        } else {
                            self.dataSource.setNews(self.news)
                            self.view?.setupTableViewDataSource(dataSource: self.dataSource)
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
    
    func loadImage(from urlString: String, for new: Model) {
        self.networkService.loadImage(urlString: urlString) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    new.image = data
                    self.dataSource.setNews(self.news)
                    self.view?.setupTableViewDataSource(dataSource: self.dataSource)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
}
