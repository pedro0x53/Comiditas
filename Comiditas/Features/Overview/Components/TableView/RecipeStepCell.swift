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
        imageView.tintColor = Colors.primary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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

        let startPoint = CGPoint(x: completedMark.frame.midX,
                                 y: completedMark.frame.maxY + 4)
        let endPoint = CGPoint(x: completedMark.frame.midX,
                               y: descriptionLabel.frame.maxY + 4)

        if FeatureFlags.currentStep.isEnable {
            if self.finished {
                if let image = UIImage(systemName: "checkmark.circle.fill") {
                    let templateImage = image.withRenderingMode(.alwaysTemplate)
                    self.completedMark.image = templateImage
                }

                self.completedMark.layer.borderColor = Colors.primary.cgColor
                self.drawDashedLine(from: startPoint, to: endPoint, color: Colors.primary,
                                    strokeLength: 3, gapLength: 1, width: 1.5)
            } else {
                self.drawDashedLine(from: startPoint, to: endPoint, color: Colors.textMedium,
                                    strokeLength: 3, gapLength: 1, width: 1.5)
            }
        } else {
            self.drawDashedLine(from: startPoint, to: endPoint, color: Colors.textMedium,
                                strokeLength: 3, gapLength: 1, width: 1.5)
        }
    }

    func setupView() {
        contentView.addSubview(completedMark)
        completedMark.layer.cornerRadius = 10
        completedMark.layer.borderColor = Colors.textMedium.cgColor
        completedMark.layer.borderWidth = 1.5

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            completedMark.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            completedMark.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            completedMark.heightAnchor.constraint(equalToConstant: 20),
            completedMark.widthAnchor.constraint(equalToConstant: 20),

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
