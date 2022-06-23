//
//  HomeView.swift
//  News App
//
//  Created by Даниил Хайбуллин on 20.06.2022.
//

import UIKit

protocol IFavoriteView: AnyObject {
    func setupTableViewDataSource(dataSource: FavoriteDataSource)
    var cellTapedHandler: ((Int) -> ())? { get set }
}

protocol IHomeView: AnyObject {
    func setupTableViewDataSource(dataSource: HomeDataSource)
    var searchHandler: ((String?) -> ())? { get set }
    var cellTapedHandler: ((Int) -> ())? { get set }
}

final class CustomView: UIView {
    
    private enum Constraint {
        static let searchTopAnchor: CGFloat = 16
        static let searchLeftRightAnchor: CGFloat = 15
        static let filterTopAnchor: CGFloat = 24
        static let filterLeadingAnchor: CGFloat = 15
        static let filterHeightAnchor: CGFloat = 32
        static let tableViewTopAnchor: CGFloat = 8
        static let tableViewHorizontalOffset: CGFloat = 15
    }
    private enum Constant {
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
    private var flag: Bool
    
    var searchHandler: ((String?) -> ())?
    var cellTapedHandler: ((Int) -> ())?
    
    init() {
        self.flag = true
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.configureTableView()
        self.setupLayout()
        self.searchTextField.adoptDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
    }
    
    func setFavoriteView(_ flag: Bool) -> CustomView {
        self.flag = !flag
        self.setupLayout()
        return self
    }
}

extension CustomView: IHomeView {
    func setupTableViewDataSource(dataSource: HomeDataSource) {
        self.tableView.dataSource = dataSource
        self.tableView.reloadData()
    }
}

extension CustomView: IFavoriteView {
    func setupTableViewDataSource(dataSource: FavoriteDataSource) {
        self.tableView.dataSource = dataSource
        self.tableView.reloadData()
    }
}

extension CustomView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellTapedHandler?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.rowHeight
    }
}

extension CustomView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchHandler?(textField.text)
        textField.resignFirstResponder()
        return true
    }
}

private extension CustomView {
    func setupLayout() {
        if flag {
            self.setupLayoutForHomeView()
        } else {
            self.setupLayoutForFavoriteView()
        }
    }
    
    func setupLayoutForHomeView() {
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
    
    func setupLayoutForFavoriteView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraint.tableViewTopAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraint.tableViewHorizontalOffset),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraint.tableViewHorizontalOffset),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
