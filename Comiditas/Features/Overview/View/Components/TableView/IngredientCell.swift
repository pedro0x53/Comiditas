//
//  IngedientCell.swift
//  Comiditas
//
//  Created by Pedro Sousa on 22/09/21.
//

import UIKit

class IngredientCell: UITableViewCell, BaseViewProtocol {
    public static let identifier: String = "IngredientCellIdentifier"

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = Fonts.h6
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        contentView.addSubview(contentLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(text: String) {
        self.contentLabel.text = "• " + text
        self.contentLabel.accessibilityLabel = text
    }
}
