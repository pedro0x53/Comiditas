//
//  SectionHeaderView.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//

import UIKit

protocol SectionHeaderViewDelegate: AnyObject {
    func copySectionContent(type: OverviewCopyType)
}

class SectionHeaderView: UITableViewHeaderFooterView, BaseViewProtocol {

    public static let identifier: String = "SectionHeaderViewIdentifier"

    weak var delegate: SectionHeaderViewDelegate?
    private var sectionType: OverviewCopyType?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h4Bold
        label.textColor = Colors.primary
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let copyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
        setupCopyAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(titleLabel)
        titleLabel.isAccessibilityElement = true

        contentView.addSubview(copyButton)
        copyButton.isAccessibilityElement = true

        if #available(iOS 15, *) {
            var config = UIButton.Configuration.filled()
            config.cornerStyle = .capsule
            config.baseBackgroundColor = Colors.secondary
            config.baseForegroundColor = Colors.primary

            var container = AttributeContainer()
            container.font = UIFont.boldSystemFont(ofSize: 15)
            config.attributedTitle = AttributedString("Copiar", attributes: container)

            copyButton.configuration = config
        } else {
            copyButton.layer.cornerRadius = 15
            copyButton.setTitle("Copiar", for: .normal)
            copyButton.backgroundColor = Colors.secondary
            copyButton.setTitleColor(Colors.primary, for: .normal)
            copyButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
            copyButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            copyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            copyButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            copyButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(title: String, type: OverviewCopyType) {
        self.titleLabel.text = title
        self.titleLabel.accessibilityLabel = title
        self.sectionType = type

        switch type {
        case .ingredients:
            copyButton.accessibilityLabel = "\(OverviewLocalizable.copy.text) \(OverviewLocalizable.ingredients.text)"
            copyButton.accessibilityHint = OverviewLocalizable.copyIngredintsHint.text
        case .direcions:
            copyButton.accessibilityLabel = "\(OverviewLocalizable.copy.text) \(OverviewLocalizable.directions.text)"
            copyButton.accessibilityHint = OverviewLocalizable.copyDirectionsHint.text
        }
    }

    private func setupCopyAction() {
        copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
    }

    @objc func copyAction() {
        if let type = self.sectionType {
            self.delegate?.copySectionContent(type: type)
        }
    }
}
