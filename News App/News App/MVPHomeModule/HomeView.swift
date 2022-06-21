//
//  HomeView.swift
//  News App
//
//  Created by Даниил Хайбуллин on 20.06.2022.
//

import UIKit

final class HomeView: UIView {
    
    enum Constraint {
        static let searchTopAnchor: CGFloat = 16
        static let searchLeftRightAnchor: CGFloat = 15
        static let filterTopAnchor: CGFloat = 24
        static let filterLeadingAnchor: CGFloat = 15
        static let filterHeightAnchor: CGFloat = 32
        static let tableViewTopAnchor: CGFloat = 8
        static let tableViewHorizontalOffset: CGFloat = 15
    }
    enum Constant {
        static let spacingBetweenCell: CGFloat = 8
        static let searchHeightAnchor: CGFloat = 32
        static let cornerRadius: CGFloat = 16
        static let borderWidth: CGFloat = 1
        static let emptyViewWidth: CGFloat = 16
        static let searchImageWidthHeight = 12
        static let rowHeight: CGFloat = 128
    }
    
    private let searchTextField = CustomTextField()
    private let filterCollectionView = HorizontalFilterCollectionView()
    private let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.configureTableView()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.id)
    }
}

extension HomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.id, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        cell.contentView.frame.inset(by: .init(top: 8, left: 0, bottom: 8, right: 0))
        return cell
    }
}

extension HomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.rowHeight
    }
}

private extension HomeView {
    func setupLayout() {
        self.searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.searchTextField)
        NSLayoutConstraint.activate([
            self.searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraint.searchTopAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.searchLeftRightAnchor),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.searchLeftRightAnchor),
            self.searchTextField.heightAnchor.constraint(equalToConstant: Constant.searchHeightAnchor)
        ])
        
        self.filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.filterCollectionView)
        NSLayoutConstraint.activate([
            self.filterCollectionView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor, constant: Constraint.filterTopAnchor),
            self.filterCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.filterLeadingAnchor),
            self.filterCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.filterCollectionView.heightAnchor.constraint(equalToConstant: Constraint.filterHeightAnchor)
        ])
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.filterCollectionView.bottomAnchor, constant: Constraint.tableViewTopAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.tableViewHorizontalOffset),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.tableViewHorizontalOffset),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
