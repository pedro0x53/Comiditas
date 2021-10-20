//
//  DetailView.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//

import UIKit

class DetailView: UIView {
    private let stack: UIStackView = {
       let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isAccessibilityElement = false
        return stack
    }()

    let iconName: String

    private let iconImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.isAccessibilityElement = false
        return imageView
    }()

    var itemDescription: String {
        didSet {
            self.descriptionLabel.text = itemDescription
        }
    }

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Fonts.h5
        label.isAccessibilityElement = false
        return label
    }()

    init(iconName: String, description: String) {
        self.itemDescription = description
        self.iconName = iconName

        super.init(frame: .zero)

        self.isAccessibilityElement = true

        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailView: BaseViewProtocol {
    func setupView() {
        addSubview(stack)
        stack.addArrangedSubview(iconImage)
        iconImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 30).isActive = true

        if let systemImage = UIImage(systemName: iconName) {
            let templateImage = systemImage.withRenderingMode(.alwaysTemplate)
            self.iconImage.image = templateImage
            self.tintColor = Colors.primary
        }

        stack.addArrangedSubview(descriptionLabel)

        shouldGroupAccessibilityChildren = true
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
