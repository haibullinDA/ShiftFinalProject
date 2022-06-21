//
//  HorizontalFilterCollectionViewCell.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class HorizontalFilterCollectionViewCell: UICollectionViewCell {
    
    enum Constant {
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 16
    }
    
    static let id = String(describing: HorizontalFilterCollectionViewCell.self)
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = Nunito.semiBold12.font
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.backgroundColor = Colors.pink.value
                self.textLabel.textColor = .white
            } else {
                self.backgroundColor = .white
                self.textLabel.textColor = .black
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HorizontalFilterCollectionViewCell {
    func configure() {
        layer.cornerRadius = Constant.cornerRadius
        layer.borderWidth = Constant.borderWidth
        layer.borderColor = Colors.grey.value.cgColor
    }
    
    func setupLayout() {
        self.contentView.addSubview(self.textLabel)
        NSLayoutConstraint.activate([
            self.textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
