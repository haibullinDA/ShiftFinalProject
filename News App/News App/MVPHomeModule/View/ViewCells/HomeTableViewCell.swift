//
//  HomeTableViewCell.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    enum Constraint {
        static let standartSpacing: CGFloat = 8
    }
    
    enum Constant {
        static let cornerRadius: CGFloat = 8
        static let stackViewSpacing: CGFloat = 0
        static let stackViewHeightAnchor: CGFloat = 21
    }

    private let view = UIView()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = Constant.cornerRadius
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = NewYorkSmall.semiBold14.font
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = Nunito.semiBold12.font
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Nunito.semiBold12.font
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
    
    static let id = String(describing: HomeTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayData(_ model: Model) {
        self.titleLabel.text = model.title
        self.authorLabel.text = model.author
        self.dateLabel.text = model.date
        self.backgroundImageView.image = UIImage(data: model.image ?? Data())
    }
}

private extension HomeTableViewCell {
    func configure() {
        self.setupBackGround()
        self.setupLayout()
    }
    
    func setupLayout() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.view)
        NSLayoutConstraint.activate([
            self.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Constraint.standartSpacing),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constraint.standartSpacing),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constraint.standartSpacing),
        ])
        
        let stackView = self.stackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Constraint.standartSpacing),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constraint.standartSpacing),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constraint.standartSpacing),
            stackView.heightAnchor.constraint(equalToConstant: Constant.stackViewHeightAnchor )
        ])
    }
    
    func setupBackGround() {
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.backgroundImageView)
        NSLayoutConstraint.activate([
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func stackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.addArrangedSubview(self.authorLabel)
        stackView.addArrangedSubview(self.dateLabel)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = Constant.stackViewSpacing
        return stackView
    }
}
