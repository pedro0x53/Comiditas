//
//  FeedView.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

protocol FeedViewProtocol: AnyObject {
    func tapSearchBar()
}

class FeedView: UIView {
    weak var delegate: FeedViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.subTitle
        label.textColor = Colors.textDark
        label.text = FeedLocalizable.subTitle.text
        return label
    }()

    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = FeedLocalizable.search.text
        search.isAccessibilityElement = true
        search.accessibilityValue = "Pesquisar"
        search.sizeToFit()
        search.isTranslucent = false
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = Colors.background
        search.searchBarStyle = .minimal
        search.enablesReturnKeyAutomatically = false
        search.searchTextField.backgroundColor = Colors.secondary
        search.searchTextField.leftView?.tintColor = Colors.primary
        return search
    }()

    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        searchBar.searchTextField.addGestureRecognizer(tap)
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        tableView.register(RecipesTableViewCell.self, forCellReuseIdentifier: "RecipesTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Colors.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 320
        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        return tableView
    }()

    @objc func handleTap() {
        delegate?.tapSearchBar()
    }
}

extension FeedView: BaseViewProtocol {
    private struct Metrics {
        static let tableViewTop: CGFloat = 10
        static let cellCollectionViewConstant = (width: UIScreen.main.bounds.width * 0.30, height: CGFloat(40))
    }

    func setupView() {
        self.backgroundColor = Colors.background
        self.addSubview(subTitleLabel)
        self.addSubview(searchBar)
        self.addSubview(tableView)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 18),

            searchBar.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
