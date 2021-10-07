//
//  RecipeStepCell.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//

import UIKit

class RecipeStepCell: UITableViewCell, BaseViewProtocol {

    public static let identifier: String = "RecipeStepCellIdentifier"

    var finished: Bool = false

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h5
        label.numberOfLines = 1
        label.textColor = Colors.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h6
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let completedMark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = Colors.textMedium
        imageView.translatesAutoresizingMaskIntoConstraints = false

        if let image = UIImage(systemName: "checkmark.circle.fill") {
            let templateImage = image.withRenderingMode(.alwaysTemplate)
            imageView.image = templateImage
        }

        return imageView
    }()

    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.textMedium
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if FeatureFlags.currentStep.isEnable {
            if self.finished {
                self.completedMark.layer.borderColor = Colors.primary.cgColor
                line.backgroundColor = Colors.primary
            }
        }
    }

    func setupView() {
        if FeatureFlags.currentStep.isEnable {
            contentView.addSubview(completedMark)
            completedMark.layer.cornerRadius = 10
            completedMark.layer.borderColor = Colors.textMedium.cgColor
            completedMark.layer.borderWidth = 1.5
            contentView.addSubview(line)
        }

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    func setupConstraints() {
        if FeatureFlags.currentStep.isEnable {
            setupConstraintsWithCheckMark()
        } else {
            setupConstraintsWithoutCheckMark()
        }
    }

    private func setupConstraintsWithoutCheckMark() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func setupConstraintsWithCheckMark() {
        NSLayoutConstraint.activate([
            completedMark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            completedMark.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            completedMark.heightAnchor.constraint(equalToConstant: 20),
            completedMark.widthAnchor.constraint(equalToConstant: 20),

            line.widthAnchor.constraint(equalToConstant: 1.5),
            line.centerXAnchor.constraint(equalTo: completedMark.centerXAnchor),
            line.topAnchor.constraint(equalTo: completedMark.bottomAnchor, constant: 4),
            line.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.centerYAnchor.constraint(equalTo: completedMark.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: completedMark.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(title: String, description: String, finished: Bool = false) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.finished = finished

        shouldGroupAccessibilityChildren = true
        accessibilityLabel = title + description
    }
}
