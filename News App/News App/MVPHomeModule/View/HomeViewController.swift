//
//  HomeViewController.swift
//  News App
//
//  Created by Даниил Хайбуллин on 20.06.2022.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private let customView = CustomView()
    private let presenter: IHomePresenter
    
    init(presenter: IHomePresenter) {
        self.presenter = presenter
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(view: self.customView, controller: self)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        self.view = customView
    }
}
