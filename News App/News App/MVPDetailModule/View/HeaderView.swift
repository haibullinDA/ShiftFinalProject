//
//  HeaderView.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class HeaderView: UIView {
    
    struct Setting {
        let title: String
        let author: String
        let date: String
    }
    
    private enum Constraint {
        static let horizontakOffset: CGFloat = 24
        
        static let dateLabelTopAnchor: CGFloat = 16
        static let authorLabelBottomAnchor: CGFloat = 16
        static let titleLabelTopAnchor: CGFloat = 8
        static let titleLabelBottomAnchor: CGFloat = 8
    }
    private enum Constant {
        static let viewCornerRadius: CGFloat = 16
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Nunito.semiBold12.font
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = NewYorkSmall.bold16.font
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Nunito.extraBold10.font
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayData(with setting: Setting) {
        self.titleLabel.text = setting.title
        self.authorLabel.text = setting.author
        self.dateLabel.text = setting.date
    }
    
    private func configure() {
        self.layer.cornerRadius = Constant.viewCornerRadius
        self.backgroundColor = Colors.greyBackground.value
        self.setupLayout()
    }
}

private extension HeaderView {
    func setupLayout() {
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.dateLabel)
        NSLayoutConstraint.activate([
            self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraint.dateLabelTopAnchor),
            self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.horizontakOffset),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.horizontakOffset)
        ])
        
        self.authorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.authorLabel)
        NSLayoutConstraint.activate([
            self.authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.horizontakOffset),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.horizontakOffset),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraint.authorLabelBottomAnchor)
        ])
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: Constraint.titleLabelTopAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.horizontakOffset),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.horizontakOffset),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.authorLabel.topAnchor, constant: -Constraint.titleLabelBottomAnchor)
        ])
    }
}
