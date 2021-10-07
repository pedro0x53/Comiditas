//
//  FeedCollectionViewCell.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
            super.prepareForReuse()
            imageView.image = nil
    }

    override func layoutSubviews() {
        setupUI()
    }

    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = Colors.background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h4
        label.textColor = Colors.primary
        label.text = "Lorem ipsum dolor sit amet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h6
        label.textColor = Colors.textDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .purple
        imageView.image = UIImage(assetIdentifier: .imgPizza)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var userTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h6
        label.textColor = Colors.textDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension FeedCollectionViewCell {
    private func setupUI() {
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(imageView)
        roundedBackgroundView.addSubview(titleLabel)
        roundedBackgroundView.addSubview(subtitleLabel)
        if FeatureFlags.user.isEnable {
            roundedBackgroundView.addSubview(userImageView)
            roundedBackgroundView.addSubview(userTitleLabel)
        }

        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            roundedBackgroundView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            roundedBackgroundView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),

            imageView.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: roundedBackgroundView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: roundedBackgroundView.heightAnchor, multiplier: 0.6),

            titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.roundedBackgroundView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.roundedBackgroundView.trailingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.roundedBackgroundView.leadingAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.roundedBackgroundView.trailingAnchor)
        ])

        if FeatureFlags.user.isEnable {
            NSLayoutConstraint.activate([
                userImageView.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 8),
                userImageView.leadingAnchor.constraint(equalTo: self.roundedBackgroundView.leadingAnchor, constant: 8),
                userImageView.heightAnchor.constraint(equalToConstant: 30),
                userImageView.widthAnchor.constraint(equalToConstant: 30),

                userTitleLabel.leadingAnchor.constraint(equalTo: self.userImageView.trailingAnchor, constant: 8),
                userTitleLabel.centerYAnchor.constraint(equalTo: self.userImageView.centerYAnchor)
            ])
        }

    }
}
