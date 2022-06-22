//
//  NetworkService.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation
import CloudKit

protocol INetworkService: AnyObject {
    func loadNews<T: Codable>(complition: @escaping (Result<T, Error>) -> Void)
    func loadImage(urlString: String, complition: @escaping (Result<Data, Error>) -> Void)
    func addParam(_ param: String, for value: String?)
}

final class NetworkService {
    enum Param: String {
        case category
        case page
        case q
    }
    private var params: [String: String?] = [Param.category.rawValue : nil,
                                             Param.page.rawValue : nil,
                                             Param.q.rawValue: nil]
    private let baseStringURL = "https://newsdata.io/api/1/news?apikey=pub_8577aaf878ab44f9237aca8c8bd0e3279bfa"
    
    private func url() -> URL? {
        var urlString = self.baseStringURL
        for (param,value) in params {
            if let value = value {
                urlString = urlString + "&\(param)=" + value
            }
        }
        return URL(string: urlString)
    }
}

extension NetworkService: INetworkService {
    
    func addParam(_ param: String, for value: String?) {
        self.params[param] = value
    }
    
    
    func loadNews<T: Codable>(complition: @escaping (Result<T, Error>) -> Void) {
        guard let url = url() else { return }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let error = error {
                complition(.failure(error))
            }
            guard let data = data else { return }
            do {
                let dto = try JSONDecoder().decode(T.self, from: data)
                complition(.success(dto))
            } catch let error {
                complition(.failure(error))
            }
        }.resume()
    }
    
    func loadImage(urlString: String, complition: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.downloadTask(with: request) { url, responceURL, error in
            if let error = error {
                complition(.failure(error))
            }
            guard let url = url else { return }
            do {
                let data = try Data(contentsOf: url)
                complition(.success(data))
            } catch let error {
                complition(.failure(error))
            }
        }.resume()
    }
}
