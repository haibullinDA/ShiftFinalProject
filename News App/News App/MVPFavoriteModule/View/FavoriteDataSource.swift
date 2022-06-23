//
//  FavoriteDataSource.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import Foundation
import UIKit

final class FavoriteDataSource: NSObject {
    
    public var loadHandler: (() -> ())?
    
    private var news: [FavoriteModel]
    
    init(news: [FavoriteModel]) {
        self.news = news
    }
    
    func setNews(_ news: [FavoriteModel]) {
        self.news = news
    }
}

extension FavoriteDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.displayData(news[indexPath.row])
        return cell
    }
}
