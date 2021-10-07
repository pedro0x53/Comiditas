//
//  SectionHeaderView.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView, BaseViewProtocol {

    public static let identifier: String = "SectionHeaderViewIdentifier"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h4
        label.textColor = Colors.primary
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(titleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(title: String) {
        self.titleLabel.text = title
        self.titleLabel.accessibilityLabel = title
    }
}
