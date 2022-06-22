//
//  FavoriteViewController.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import UIKit

final class FavoriteViewController: BaseViewController {
    
    private let customView = CustomView().setFavoriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        self.view = customView
    }
}
