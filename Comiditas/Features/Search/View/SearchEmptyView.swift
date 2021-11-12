//
//  SearchEmptyView.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 09/11/21.
//

import UIKit

class SearchEmptyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var imageEmpty: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(assetIdentifier: .emptyImage)
        image.isAccessibilityElement = true
        image.accessibilityTraits = .image
        image.accessibilityValue = "Um ovo voador para idenficar o não encontramos a receita."
        return image
    }()

    lazy var textEmptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Receita não encontrada"
        label.isAccessibilityElement = true
        label.accessibilityTraits = .staticText
        label.font = Fonts.h3
        label.textColor = Colors.textDark
        return label
    }()

    func setupView() {
        self.backgroundColor = Colors.background

        addSubview(imageEmpty)
        addSubview(textEmptyLabel)
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageEmpty.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageEmpty.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            textEmptyLabel.topAnchor.constraint(equalTo: self.imageEmpty.bottomAnchor),
            textEmptyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
