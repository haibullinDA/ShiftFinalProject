//
//  FileManagerService.swift
//  News App
//
//  Created by Даниил Хайбуллин on 22.06.2022.
//

import Foundation

final class FileManagerService {
    
    static let shared = FileManagerService()
    private init() {}
    
    private let fileManager = FileManager.default
    
    private func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(fileName)
    }
}

extension FileManagerService {
    func saveImage(_ imageData: Data?, withName name: String) {
        guard let url = self.makeURL(forFileNamed: name) else { return }
        guard let data = imageData else { return }
        guard self.fileManager.fileExists(atPath: url.path) == false else { return }
        try? data.write(to: url)
    }
    func readImage(withName name: String?) -> Data? {
        guard let name = name else { return nil }
        guard let url = self.makeURL(forFileNamed: name) else { return nil }
        guard fileManager.fileExists(atPath: url.path) else { return nil }
        return try? Data(contentsOf: url)
    }
    func deleteImage(withName name: String?) {
        guard let name = name else { return }
        guard let url = self.makeURL(forFileNamed: name) else { return }
        guard fileManager.fileExists(atPath: url.path) else { return }
        try? fileManager.removeItem(at: url)
    }
}
