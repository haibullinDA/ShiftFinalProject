//
//  DetailView.swift
//  News App
//
//  Created by Даниил Хайбуллин on 21.06.2022.
//

import UIKit

protocol IDetailView: AnyObject {
    func displayData(_ detailModel: DetailModel)
    var backHandler: (() -> ())? { get set }
    var favoriteHandler: (() -> ())? { get set }
}

final class DetailView: UIView {

    private enum Constraint {
        static let backButtonTopAnchor: CGFloat = 8
        static let backButtonLeadingAnchor: CGFloat = 15
        
        static let textViewTopAnchor: CGFloat = 20
        static let contentLabelTopAnchor: CGFloat = 88
        static let headerViewBottomAnchor: CGFloat = 80
        static let headerHorizontalAnchor: CGFloat = 32
        static let favoriteButtonTrailingAnchor: CGFloat = 15
        static let favoriteButtonBottomAnchor: CGFloat = 48
    }
    private enum Constant {
        static let backButtonCornerRadius: CGFloat = 10
        static let favoriteButtonCornerRadius: CGFloat = 28
        
        static let backButtonHeightWidth: CGFloat = 32
        static let favoriteButtonHeightWidth: CGFloat = 56
        static let imageHeight: CGFloat = 400
        
    }
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.back.image, for: .normal)
        button.backgroundColor = Colors.greyBackground.value
        button.layer.cornerRadius = Constant.backButtonCornerRadius
        return button
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.test.image
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    private let headerView = HeaderView()
    private let textView = CustomTextView()
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.favorite.image, for: .normal)
        button.backgroundColor = Colors.pink.value
        button.layer.cornerRadius = Constant.favoriteButtonCornerRadius
        return button
    }()
    
    var favoriteHandler: (() -> ())?
    var backHandler: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.configure()
        self.backHandler?()
        self.addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.setupLayout()
    }
    
    private func addTarget() {
        self.backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc
    private func back() {
        self.backHandler?()
    }
}

extension DetailView: IDetailView {
    func displayData(_ detailModel: DetailModel) {
        self.imageView.image = UIImage(data: detailModel.image ?? Data())
        self.headerView.displayData(with: .init(title: detailModel.title,
                                                author: detailModel.author ?? "",
                                                date: detailModel.date))
        self.textView.displayData(detailModel.content ?? detailModel.description ?? "")
    }
}

private extension DetailView {
    func setupLayout() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight)
        ])
        
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.textView)
        NSLayoutConstraint.activate([
            self.textView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -Constraint.textViewTopAnchor),
            self.textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerView)
        NSLayoutConstraint.activate([
            self.headerView.bottomAnchor.constraint(equalTo: self.textView.topAnchor, constant: Constraint.headerViewBottomAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.headerHorizontalAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.headerHorizontalAnchor)
        ])
        
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.backButton)
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraint.backButtonTopAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.backButtonLeadingAnchor),
            self.backButton.heightAnchor.constraint(equalToConstant: Constant.backButtonHeightWidth),
            self.backButton.widthAnchor.constraint(equalToConstant: Constant.backButtonHeightWidth)
        ])
        
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.favoriteButton)
        NSLayoutConstraint.activate([
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.favoriteButtonTrailingAnchor),
            self.favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraint.favoriteButtonBottomAnchor),
            self.favoriteButton.heightAnchor.constraint(equalToConstant: Constant.favoriteButtonHeightWidth),
            self.favoriteButton.widthAnchor.constraint(equalToConstant: Constant.favoriteButtonHeightWidth)
        ])
    }
}
