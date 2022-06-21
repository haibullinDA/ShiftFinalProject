//
//  Assets.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

enum Assets {
    case test
    case search
    case homeGrey
    case homePink
    case favoriteGrey
    case favoritePink
    case back
    case favorite
    
    var image: UIImage? {
        switch self {
        case .test:
            return UIImage(named: "test")
        case .search:
            return UIImage(named: "search")
        case .homeGrey:
            return UIImage(named: "homeGrey")
        case .homePink:
            return UIImage(named: "homePink")
        case .favoriteGrey:
            return UIImage(named: "favoriteGrey")
        case .favoritePink:
            return UIImage(named: "favoritePink")
        case .back:
            return UIImage(named: "back")
        case .favorite:
            return UIImage(named: "favorite")
        }
    }
}
