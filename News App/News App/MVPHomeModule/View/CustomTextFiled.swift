//
//  CustomTextFiled.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class CustomTextField: UIView {
    
    private enum Constrain {
        static let imageViewVerticalAnchor: CGFloat = 10
    }
    private enum Constant {
        static let textFieldBorderWidth: CGFloat = 0
        static let emptyViewWidth: CGFloat = 16
        static let viewCornerRadius: CGFloat = 16
        static let viewBorderWidth: CGFloat = 1
        static let imageViewHeightWidth: CGFloat = 12
    }
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = Constant.textFieldBorderWidth
        textField.placeholder = "Search"
        return textField
    }()
    
    private let imageView = UIImageView(image: Assets.search.image)
    private let emptyViewLeft = UIView()
    private let emptyViewRight = UIView()
    
    init() {
        super.init(frame: .zero)
        self.imageView.contentMode = .scaleAspectFit
        self.setupLayout()
        self.layer.cornerRadius = Constant.viewCornerRadius
        self.layer.borderWidth = Constant.viewBorderWidth
        self.layer.borderColor = Colors.grey.value.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func adoptDelegate(_ delegate: UITextFieldDelegate) {
        self.searchTextField.delegate = delegate
    }
}

private extension CustomTextField {
    func setupLayout() {
        self.emptyViewLeft.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.emptyViewLeft)
        NSLayoutConstraint.activate([
            self.emptyViewLeft.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.emptyViewLeft.topAnchor.constraint(equalTo: self.topAnchor),
            self.emptyViewLeft.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.emptyViewLeft.widthAnchor.constraint(equalToConstant: Constant.emptyViewWidth)
        ])
        self.emptyViewRight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.emptyViewRight)
        NSLayoutConstraint.activate([
            self.emptyViewRight.topAnchor.constraint(equalTo: self.topAnchor),
            self.emptyViewRight.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.emptyViewRight.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.emptyViewRight.widthAnchor.constraint(equalToConstant: Constant.emptyViewWidth)
        ])
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constrain.imageViewVerticalAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.emptyViewRight.leadingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constrain.imageViewVerticalAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: Constant.imageViewHeightWidth),
            self.imageView.widthAnchor.constraint(equalToConstant: Constant.imageViewHeightWidth)
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
}
