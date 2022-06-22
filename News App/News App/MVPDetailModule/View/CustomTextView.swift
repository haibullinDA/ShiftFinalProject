//
//  CustomTextView.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class CustomTextView: UIView {
    
    private enum Constraint {
        static let textViewHorizontalAnchor: CGFloat = 15
    }
    private enum Constant {
        static let emptyViewHeight: CGFloat = 88
        static let viewCornerRadius: CGFloat = 24
    }
    
    private let emptyView = UIView()
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = Nunito.semiBold14.font
        textView.textAlignment = .left
        textView.isEditable = false
        return textView
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayData(_ text: String) {
        self.textView.text = text
    }
    
    private func configure() {
        self.layer.cornerRadius = Constant.viewCornerRadius
        self.setupLayout()
    }
}

private extension CustomTextView {
    func setupLayout() {
        self.emptyView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyView.clipsToBounds = true
        self.addSubview(self.emptyView)
        NSLayoutConstraint.activate([
            self.emptyView.topAnchor.constraint(equalTo: self.topAnchor),
            self.emptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.emptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.emptyView.heightAnchor.constraint(equalToConstant: Constant.emptyViewHeight)
        ])
        
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.textView)
        NSLayoutConstraint.activate([
            self.textView.topAnchor.constraint(equalTo: self.emptyView.bottomAnchor),
            self.textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.textViewHorizontalAnchor),
            self.textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.textViewHorizontalAnchor),
            self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
