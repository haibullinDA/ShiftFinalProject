//
//  HomeDataSource.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation
import UIKit

final class HomeDataSource: NSObject {
    
    var loadHandler: (() -> ())?
    
    private var news: [HomeModel]
    
    init(news: [HomeModel]) {
        self.news = news
    }
    
    func setNews(_ news: [HomeModel]) {
        self.news = news
    }
}

extension HomeDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.displayData(news[indexPath.row])
        if indexPath.row == self.news.count - 4 {
            self.loadHandler?()
        }
        return cell
    }
}
