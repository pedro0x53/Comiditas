//
//  SettingsHeaderView.swift
//  Comiditas
//
//  Created by Brena Amorim on 28/10/21.
//

import UIKit

class SettingsHeaderView: UITableViewHeaderFooterView {

    public static let identifier: String = "Settings HeaderCellIdentifier"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textDark
        label.font = Fonts.h4Bold
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        setupContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(titleText: String) {
        titleLabel.text = titleText
    }

    func setupView() {
        self.contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
    }

    func setupContraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
}
