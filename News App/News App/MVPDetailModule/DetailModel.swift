//
//  DetailModel.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import Foundation

final class DetailModel {
    let title: String
    let author: String?
    let date: String
    var image: Data?
    let description: String?
    let content: String?
    let link: String
    
    init(with homeModel: HomeModel) {
        self.title = homeModel.title
        self.author = homeModel.author
        self.date = homeModel.date
        self.image = homeModel.image
        self.description = homeModel.description
        self.content = homeModel.content
        self.link = homeModel.link
    }
}
