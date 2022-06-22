//
//  DetailViewController.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class DetailViewController: BaseViewController {
    
    private let customView = DetailView()
    private let presenter: IDetailPresenter
    
    init(presenter: IDetailPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(view: customView, controller: self)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func loadView() {
        self.view = self.customView
    }
}
