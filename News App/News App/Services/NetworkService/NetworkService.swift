//
//  NetworkService.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import Foundation

protocol INetworkService: AnyObject {
    func loadNews<T: Codable>(complition: @escaping (Result<T, Error>) -> Void)
    func loadImage(urlString: String, complition: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService {
    private let baseStringURL = "https://newsdata.io/api/1/news?apikey=pub_8452907213db10bfe614070e52fabeef4789"
}

extension NetworkService: INetworkService {
    func loadNews<T: Codable>(complition: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseStringURL) else { return }
        
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
