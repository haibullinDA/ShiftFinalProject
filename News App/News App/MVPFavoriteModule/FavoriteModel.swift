//
//  FavoriteModel.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import Foundation

struct FavoriteModel {
    let id: UUID
    let title: String
    let author: String?
    let date: String
    var imageName: String?
    var imageData: Data?
    let description: String?
    let content: String?
    let link: String
    
    init(id: UUID, title: String, author: String?, date: String,imageName: String?, imageData: Data?, description: String?, content: String?, link: String) {
        self.id = id
        self.title = title
        self.author = author
        self.date = date
        self.imageName = imageName
        self.imageData = imageData
        self.description = description
        self.content = content
        self.link = link
    }
    
    init(newMO: NewMO) {
        self.id = newMO.id ?? UUID()
        self.title = newMO.title ?? "Default Title"
        self.author = newMO.author
        self.date = newMO.date ?? "Default Date"
        self.imageName = newMO.imageName
        self.description = newMO.descriptionResult
        self.content = newMO.content
        self.link = newMO.link ?? "Default Link"
    }
}
