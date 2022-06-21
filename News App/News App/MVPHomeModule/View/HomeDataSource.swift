//
//  HomeDataSource.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation
import UIKit

final class HomeDataSource: NSObject {
    private var news: [Model]
    
    init(news: [Model]) {
        self.news = news
    }
    
    func setNews(_ news: [Model]) {
        self.news = news
    }
}

extension HomeDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.id, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        cell.displayData(news[indexPath.row])
        return cell
    }
}
