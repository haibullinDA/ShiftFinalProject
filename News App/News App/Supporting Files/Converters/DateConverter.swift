//
//  DateConverter.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation

enum DateConverter {
    static func transformDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "EEEE, d MMM yyyy"
        guard let date = date else { assert(false, "Не удалось преобразовать дату")}
        return formatter.string(from: date)
    }
}
