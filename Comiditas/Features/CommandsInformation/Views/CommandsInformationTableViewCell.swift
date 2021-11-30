//
//  InformationTableViewCell.swift
//  Comiditas
//
//  Created by Alley Pereira on 29/11/21.
//

import UIKit

class CommandsInformationTableViewCell: UITableViewCell {

    static let identifier: String = "InformationTableViewCell"

    // MARK: - Property views

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h6Bold
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isAccessibilityElement = true
        label.textColor = Colors.textDark
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h6
        label.numberOfLines = 0
        label.textColor = Colors.textDark
        label.isAccessibilityElement = true
        return label
    }()

    // MARK: View Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Setup
    private func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
    }

    private func setupConstraints() {

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 15
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 20
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: 20
            ),
            titleLabel.bottomAnchor.constraint(
                equalTo: descriptionLabel.topAnchor,
                constant: -5
            ),

            descriptionLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor,
                constant: 15
            ),
            descriptionLabel.trailingAnchor.constraint(
                equalTo: titleLabel.trailingAnchor
            ),
            descriptionLabel.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -15
            )
        ])
    }
}
