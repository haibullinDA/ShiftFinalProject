//
//  HomeModel.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation

final class Model {
    let title: String
    let author: String?
    let date: String
    var image: Data?
    let description: String?
    let content: String?
    let link: String
    
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
        self.link = newDTO.link
    }
}
