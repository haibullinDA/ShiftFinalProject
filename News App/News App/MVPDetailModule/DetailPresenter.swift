//
//  DetailPresenter.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import Foundation

protocol IDetailPresenter: AnyObject {
    func viewDidLoad(view: IDetailView, controller: DetailViewController)
    func viewWillAppear()
}

final class DetailPresenter<Model> {
    weak var view: IDetailView?
    weak var controller: DetailViewController?
    private let model: Model
    private let dbService: IDetailDataBaseService
    
    init(dbService: IDetailDataBaseService, model: Model) {
        self.dbService = dbService
        self.model = model
    }
}

extension DetailPresenter: IDetailPresenter {
    func viewDidLoad(view: IDetailView, controller: DetailViewController) {
        self.view = view
        self.controller = controller
        if let homeModel = self.castModelToHomeModel() {
            self.view?.displayData(.init(with: homeModel))
        }
        self.backHandler()
        self.favoriteHandler()
    }
    
    func viewWillAppear() {
        guard let model = self.castModelToHomeModel() else { return }
        if self.dbService.objectExist(withLink: model.link) {
            self.view?.disableFavoriteButton()
        } else {
            self.view?.enableFavoriteButton()
        }
    }
}

private extension DetailPresenter {
    func backHandler() {
        self.view?.backHandler = {
            self.controller?.navigationController?.popViewController(animated: true)
        }
    }
    
    func favoriteHandler() {
        self.view?.favoriteHandler = { state in
            guard let homeModel = self.castModelToHomeModel() else { return }
            guard let state = state else { return }
            if state {
                guard let favoriteModel = self.castModelToFavoriteModel(withName: self.generateName()) else { return }
                if let name = favoriteModel.imageName {
                    FileManagerService.shared.saveImage(homeModel.image, withName: name)
                    self.dbService.createNew(new: favoriteModel)
                    self.view?.disableFavoriteButton()
                }
            } else {
                guard let homeModel = self.castModelToHomeModel() else { return }
                guard let name = self.dbService.deleteObject(withLink: homeModel.link) else { return }
                FileManagerService.shared.deleteImage(withName: name)
                self.view?.enableFavoriteButton()
            }
        }
    }
    
    func generateName() -> String {
        return UUID().uuidString + ".jpg"
    }
    
    func castModelToHomeModel() -> HomeModel? {
        if let homeModel = self.model as? HomeModel {
            return homeModel
        }
        if let model = self.model as? FavoriteModel {
            let image = FileManagerService.shared.readImage(withName: model.imageName)
            let homeModel = HomeModel(title: model.title,
                                      author: model.author,
                                      date: model.date,
                                      image: image,
                                      description: model.description,
                                      content: model.content,
                                      category: [],
                                      link: model.link)
            return homeModel
        }
        return nil
    }
    
    func castModelToFavoriteModel(withName name: String?) -> FavoriteModel? {
        if let homeModel = self.model as? HomeModel {
            let favoriteModel = FavoriteModel(id: UUID(),
                                              title: homeModel.title,
                                              author: homeModel.author,
                                              date: homeModel.date,
                                              imageName: name,
                                              imageData: homeModel.image,
                                              description: homeModel.description,
                                              content: homeModel.content,
                                              link: homeModel.link)
            return favoriteModel
        }
        if let favoriteModel = self.model as? FavoriteModel {
            return favoriteModel
        }
        return nil
    }
}
