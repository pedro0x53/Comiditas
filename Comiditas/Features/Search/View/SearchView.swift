//
//  SearchView.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 28/10/21.
//

import UIKit

protocol SearchViewProtocol: AnyObject {}

class SearchView: UIView {
    weak var delegate: SearchViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = FeedLocalizable.search.text
        search.sizeToFit()
        search.isTranslucent = false
        search.translatesAutoresizingMaskIntoConstraints = false
        search.backgroundColor = Colors.background
        search.searchBarStyle = .minimal
        return search
    }()

    lazy var tagsView: TagsView = {
        let view = TagsView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        return view
    }()

    lazy var searchEmptyView: SearchEmptyView = {
        let view = SearchEmptyView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    lazy var buttonTag: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.primary
        button.titleLabel?.font = Fonts.h5
        button.addRightIcon(image: (UIImage(systemName: "x.circle.fill",
                                            withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?
                                        .withRenderingMode(.alwaysOriginal)
                                        .withTintColor(Colors.textLight)
                                   )!)
        button.setTitleColor(Colors.textLight, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 30)
        button.layer.masksToBounds = true
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked),
                         for: .touchUpInside)
        return button
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(RecipesTableViewCell.self, forCellReuseIdentifier: "RecipesTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Colors.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 320
        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.isHidden = true
        return tableView
    }()

    @objc func buttonClicked(sender: UIButton) {
        sender.isHidden = true
        tableView.isHidden = true
        tagsView.isHidden = false
        searchEmptyView.isHidden = true
    }
}

extension SearchView: BaseViewProtocol {
    func setupView() {
        self.backgroundColor = Colors.background
        self.addSubview(searchBar)
        self.addSubview(tagsView)
        self.addSubview(buttonTag)
        self.addSubview(tableView)
        self.addSubview(searchEmptyView)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            tagsView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 16),
            tagsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tagsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            tagsView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            buttonTag.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 16),
            buttonTag.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),

            tableView.topAnchor.constraint(equalTo: self.buttonTag.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            searchEmptyView.topAnchor.constraint(equalTo: self.buttonTag.bottomAnchor, constant: 16),
            searchEmptyView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            searchEmptyView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            searchEmptyView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
