//
//  Settings.swift
//  Comiditas
//
//  Created by Brena Amorim on 27/10/21.
//

import UIKit

class SettingsView: UIView {
    weak var delegate: SettingsViewDelegate? {
        didSet {
            tableView.delegate = self.delegate
            tableView.dataSource = self.delegate
        }
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        tableView.register(SettingsHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: SettingsHeaderView.identifier)
        tableView.register(SettingsStepsTableViewCell.self,
                           forCellReuseIdentifier: SettingsStepsTableViewCell.identifier)
    }

    func setupView() {
        addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

protocol SettingsViewDelegate: UITableViewDelegate, UITableViewDataSource {
//
}
