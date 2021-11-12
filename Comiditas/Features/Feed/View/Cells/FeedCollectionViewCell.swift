//
//  FeedCollectionViewCell.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 26/10/21.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityTraits = .image
        imageView.accessibilityLabel = "Imagem da receita"
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h4Bold
        label.textColor = Colors.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var stackViewRatings: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 4
        stack.layer.cornerRadius = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isAccessibilityElement = false
        return stack
    }()

    lazy var imageStar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(
            systemName: "star.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .regular)
        )?.withTintColor(.black, renderingMode: .alwaysOriginal)
        image.translatesAutoresizingMaskIntoConstraints = true
        image.isAccessibilityElement = true
        image.accessibilityTraits = .image
        image.accessibilityLabel = "Nota da receita: "
        return image
    }()

    lazy var labelStar: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textDark
        label.font = Fonts.h6
        label.text = "5.0"
        label.isAccessibilityElement = true
        label.accessibilityTraits = .staticText
        label.accessibilityLabel = "5."
        return label
    }()

    lazy var stackViewDetails: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isAccessibilityElement = false
        return stack
    }()

    lazy var imageTime: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(
            systemName: "clock.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .regular)
        )?.withTintColor(.black, renderingMode: .alwaysOriginal)
        image.isAccessibilityElement = false
        return image
    }()

    lazy var labelTime: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textDark
        label.font = Fonts.h6
        label.isAccessibilityElement = true
        return label
    }()

    lazy var imagePortion: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(assetIdentifier: .imgPortion)
        image.isAccessibilityElement = false
        return image
    }()

    lazy var labelPortion: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textDark
        label.font = Fonts.h6
        label.isAccessibilityElement = true
        return label
    }()
}

extension FeedCollectionViewCell {
    func setupUI() {
        self.contentView.backgroundColor = Colors.background
        self.contentView.layer.cornerRadius = 8

        contentView.insertSubview(imageView, at: 0)
        contentView.addSubview(stackViewRatings)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackViewDetails)

        stackViewRatings.addArrangedSubview(imageStar)
        stackViewRatings.addArrangedSubview(labelStar)

        stackViewDetails.addArrangedSubview(imageTime)
        stackViewDetails.addArrangedSubview(labelTime)
        stackViewDetails.addArrangedSubview(imagePortion)
        stackViewDetails.addArrangedSubview(labelPortion)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 230),

            stackViewRatings.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 20),
            stackViewRatings.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: -16),
            stackViewRatings.heightAnchor.constraint(equalToConstant: 30),
            stackViewRatings.widthAnchor.constraint(equalToConstant: 60),

            titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 3),
            titleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),

            stackViewDetails.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 6),
            stackViewDetails.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            stackViewDetails.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 3)
        ])
    }
}
