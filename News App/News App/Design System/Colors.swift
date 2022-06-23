//
//  Colors.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

enum Colors {
    case greyBackground
    case grey
    case searchGrey
    case tabBarGrey
    case pink
    case white
    case blackHalf
    
    var value: UIColor {
        switch self {
        case .greyBackground:
            return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 0.9)
        case .grey:
            return UIColor(red: 240/255, green: 241/255, blue: 250/255, alpha: 1)
        case .searchGrey:
            return UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1)
        case .tabBarGrey:
            return UIColor(red: 166/255, green: 166/255, blue: 166/255, alpha: 1)
        case .pink:
            return UIColor(red: 255/255, green: 58/255, blue: 68/255, alpha: 1)
        case .white:
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        case .blackHalf:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
}
