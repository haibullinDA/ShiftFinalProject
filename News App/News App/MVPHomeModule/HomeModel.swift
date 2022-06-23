//
//  HomeModel.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation

final class HomeModel {
    let title: String
    let author: String?
    let date: String
    var image: Data?
    let description: String?
    let content: String?
    let category: [String]
    let link: String
    
    init(title: String, author: String?, date: String, image: Data?, description: String?, content: String?, category: [String], link: String) {
        self.title = title
        self.author = author
        self.date = date
        self.image = image
        self.description = description
        self.content = content
        self.category = category
        self.link = link
    }
    
    init(with newDTO: New) {
        self.title = newDTO.title
        self.author = newDTO.creator?.first
        self.date = DateConverter.transformDate(newDTO.pubDate)
        print(self.date)
        self.description = newDTO.resultDescription
        if let content = newDTO.content {
            self.content = content
        } else {
            self.content = newDTO.resultDescription
        }
        self.category = newDTO.category
        self.link = newDTO.link
    }
}
