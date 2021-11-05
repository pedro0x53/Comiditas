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
        return view
    }()
}

extension SearchView: BaseViewProtocol {
    func setupView() {
        self.backgroundColor = Colors.background
        self.addSubview(searchBar)
        self.addSubview(tagsView)
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
            tagsView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
