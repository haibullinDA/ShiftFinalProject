//
//  FavoriteViewController.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import UIKit

final class FavoriteViewController: BaseViewController {
    
    private let customView = CustomView().setFavoriteView(true)
    private let presenter: IFavoritePresenter
    
    init(presenter: IFavoritePresenter) {
        
        self.presenter = presenter
        super.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(view: customView, controller: self)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.viewWillAppear()
        super.viewWillAppear(animated)
    }
    override func loadView() {
        self.view = self.customView
    }
}
