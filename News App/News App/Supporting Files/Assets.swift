//
//  Assets.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

enum Assets {
    case search
    case homeGrey
    case favoriteGrey
    case back
    case favorite
    
    var image: UIImage? {
        switch self {
        case .search:
            return UIImage(named: "search")
        case .homeGrey:
            return UIImage(named: "homeGrey")
        case .favoriteGrey:
            return UIImage(named: "favoriteGrey")
        case .back:
            return UIImage(named: "back")
        case .favorite:
            return UIImage(named: "favorite")
        }
    }
}
