//
//  AppFonts.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

enum Nunito {
    case light12
    case regular10
    case regular14
    case semiBold12
    case semiBold14
    case bold12
    case bold22
    case extraBold10
    case extraBold16
    case black14
    
    var font: UIFont? {
        switch self {
        case .light12:
            return UIFont(name: "Nunito-Light", size: 12)
        case .regular10:
            return UIFont(name: "Nunito-Regular", size: 10)
        case .regular14:
            return UIFont(name: "Nunito-Regular", size: 14)
        case .semiBold12:
            return UIFont(name: "Nunito-SemiBold", size: 12)
        case .semiBold14:
            return UIFont(name: "Nunito-SemiBold", size: 14)
        case .bold12:
            return UIFont(name: "Nunito-Bold", size: 12)
        case .bold22:
            return UIFont(name: "Nunito-Bold", size: 22)
        case .extraBold10:
            return UIFont(name: "Nunito-ExtraBold", size: 10)
        case .extraBold16:
            return UIFont(name: "Nunito-ExtraBold", size: 16)
        case .black14:
            return UIFont(name: "Nunito-Black", size: 14)
        }
    }
}

enum NewYorkSmall {
    case semiBold14
    case bold16
    
    var font: UIFont? {
        switch self {
        case .semiBold14:
            return UIFont(name: "NewYorkSmall-Semibold", size: 14)
        case .bold16:
            return UIFont(name: "NewYorkSmall-Bold", size: 16)
        }
    }
}
