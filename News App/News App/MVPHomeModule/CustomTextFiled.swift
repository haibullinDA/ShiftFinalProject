//
//  CustomTextFiled.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class CustomTextField: UIView {
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 0
        textField.placeholder = "Search"
        return textField
    }()
    
    private let imageView = UIImageView(image: Assets.search.image)
    
    private let emptyViewLeft = UIView(frame: .init(x: .zero, y: .zero, width: 16, height: .zero))
    private let emptyViewRight = UIView(frame: .init(x: .zero, y: .zero, width: 16, height: .zero))
    
    private func setupLayout() {
        self.emptyViewLeft.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.emptyViewLeft)
        NSLayoutConstraint.activate([
            self.emptyViewLeft.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.emptyViewLeft.topAnchor.constraint(equalTo: self.topAnchor),
            self.emptyViewLeft.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.emptyViewLeft.widthAnchor.constraint(equalToConstant: 16)
        ])
        self.emptyViewRight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.emptyViewRight)
        NSLayoutConstraint.activate([
            self.emptyViewRight.topAnchor.constraint(equalTo: self.topAnchor),
            self.emptyViewRight.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.emptyViewRight.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.emptyViewRight.widthAnchor.constraint(equalToConstant: 16)
        ])
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.imageView.trailingAnchor.constraint(equalTo: self.emptyViewRight.leadingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.imageView.heightAnchor.constraint(equalToConstant: 12),
            self.imageView.widthAnchor.constraint(equalToConstant: 12)
        ])
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.searchTextField)
        NSLayoutConstraint.activate([
            self.searchTextField.topAnchor.constraint(equalTo: self.topAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.emptyViewLeft.trailingAnchor),
            self.searchTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.imageView.leadingAnchor)
        ])
    }
    
    init() {
        super.init(frame: .zero)
        self.imageView.contentMode = .scaleAspectFit
        self.setupLayout()
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.grey.value.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
