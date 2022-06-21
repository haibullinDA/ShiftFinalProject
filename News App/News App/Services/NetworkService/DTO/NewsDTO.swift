//
//  NewsDTO.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation

// MARK: - NewsDTO
struct NewsDTO: Codable {
    let status: String
    let totalResults: Int
    let results: [New]
    let nextPage: Int
    
    enum CodingKeys: String, CodingKey {
        case status, totalResults
        case results = "results"
        case nextPage
    }
}

// MARK: - Result
struct New: Codable {
    let title: String
    let link: String
    let keywords: [String]?
    let creator: [String]?
    let resultDescription: String?
    let content: String?
    let pubDate: String
    let imageURL: String?
    //let sourceID: String
    let country, category: [String]
    let language: String

    enum CodingKeys: String, CodingKey {
        case title, link, keywords, creator
        case resultDescription = "description"
        case content, pubDate
        case imageURL = "image_url"
        //case sourceID = "source_id"
        case country, category, language
    }
}
