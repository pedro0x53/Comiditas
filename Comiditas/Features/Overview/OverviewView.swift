//
//  OverviewView.swift
//  Comiditas
//
//  Created by Pedro Sousa on 20/09/21.
//

import UIKit

class OverviewView: UIView {
    weak var delegate: OverviewViewDelegate? {
        didSet {
            tableView.delegate = self.delegate
            tableView.dataSource = self.delegate
        }
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let bottomButtonArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isAccessibilityElement = false
        return view
    }()

    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Iniciar passo a passo", for: .normal)
        button.setTitleColor(Colors.textLight, for: .normal)
        button.titleLabel?.font = Fonts.h5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Iniciar passo a passo"
        return button
    }()

    init() {
        super.init(frame: .zero)

        setupTableView()

        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier)

        tableView.register(RecipeHeaderCell.self, forCellReuseIdentifier: RecipeHeaderCell.identifier)
        tableView.register(RecipeStepCell.self, forCellReuseIdentifier: RecipeStepCell.identifier)
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
    }

    @objc func startRecipe() {
        delegate?.startRecipe()
    }
}

extension OverviewView: BaseViewProtocol {
    func setupView() {
        self.backgroundColor = .systemBackground

        addSubview(tableView)

        addSubview(bottomButtonArea)
        bottomButtonArea.backgroundColor = .systemBackground

        bottomButtonArea.addSubview(startButton)
        startButton.backgroundColor = Colors.primary
        startButton.layer.cornerRadius = 18
        startButton.addTarget(self, action: #selector(startRecipe), for: .touchUpInside)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -96),

            bottomButtonArea.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomButtonArea.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomButtonArea.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomButtonArea.heightAnchor.constraint(equalToConstant: 96),

            startButton.topAnchor.constraint(equalTo: bottomButtonArea.topAnchor, constant: 24),
            startButton.leadingAnchor.constraint(equalTo: bottomButtonArea.leadingAnchor, constant: 16),
            startButton.trailingAnchor.constraint(equalTo: bottomButtonArea.trailingAnchor, constant: -16),
            startButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

protocol OverviewViewDelegate: UITableViewDelegate, UITableViewDataSource {
    func startRecipe()
}
