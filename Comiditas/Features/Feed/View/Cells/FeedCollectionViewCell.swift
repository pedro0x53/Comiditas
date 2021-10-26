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
        imageView.image = UIImage(assetIdentifier: .imgPizza)
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var stackViewRatings: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = Colors.textLight
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
}

extension FeedCollectionViewCell {
    func setupUI() {
        self.contentView.backgroundColor = Colors.secondary
        self.contentView.layer.cornerRadius = 8

        contentView.insertSubview(imageView, at: 0)
        contentView.addSubview(stackViewRatings)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 230),

            stackViewRatings.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 20),
            stackViewRatings.trailingAnchor.con
        ])
    }
}
