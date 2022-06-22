//
//  FilterView.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit
import Foundation

final class HorizontalFilterCollectionView: UICollectionView {
    
    private let categoryLayout = UICollectionViewFlowLayout()
    private let nameCategoryArray = Category.allCases.map { $0.rawValue }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: self.categoryLayout)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.categoryLayout.minimumInteritemSpacing = 8
        self.categoryLayout.scrollDirection = .horizontal
        self.backgroundColor = .none
        self.bounces = false
        self.showsHorizontalScrollIndicator = false
        self.delegate = self
        self.dataSource = self
        self.register(HorizontalFilterCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalFilterCollectionViewCell.id)
        selectItem(at: [0,0], animated: true, scrollPosition: [])
    }
}

extension HorizontalFilterCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nameCategoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalFilterCollectionViewCell.id, for: indexPath) as? HorizontalFilterCollectionViewCell else { return UICollectionViewCell() }
        cell.textLabel.text = nameCategoryArray[indexPath.row]
        return cell
    }
}

extension HorizontalFilterCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let userInfo = [String(describing: Category.self) : self.nameCategoryArray[indexPath.row]]
        NotificationCenter.default.post(name: .setCategory, object: nil, userInfo: userInfo)
    }
}

extension HorizontalFilterCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let categoryFont = Nunito.semiBold12.font
        let categoryAttribute = [NSAttributedString.Key.font : categoryFont as Any]
        let categoryWidth = nameCategoryArray[indexPath.item].size(withAttributes: categoryAttribute).width
        return CGSize(width: categoryWidth + 32, height: collectionView.frame.height)
    }
}
