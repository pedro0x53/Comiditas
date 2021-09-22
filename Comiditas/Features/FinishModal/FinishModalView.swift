//
//  FinishModalView.swift
//  Comiditas
//
//  Created by Brena Amorim on 21/09/21.
//

import UIKit

class FinishModalView: UIView {

    let modalFrame = CGRect(x: UIScreen.main.bounds.size.width*0.05,
                            y: UIScreen.main.bounds.size.height*0.148,
                            width: UIScreen.main.bounds.size.width*0.9,
                            height: UIScreen.main.bounds.size.height*0.47)

    override init(frame: CGRect) {
        super.init(frame: modalFrame)
        customView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func customView() {
        self.layer.cornerRadius = 20
        self.backgroundColor = Colors.secondary
        self.layer.borderWidth = 1.5
        self.layer.borderColor = Colors.primary.cgColor
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h3
        label.textColor = Colors.primary
        label.text = "Receita Finalizada!"
        label.isAccessibilityElement = true
        label.accessibilityLabel = "Receita Finalizada!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.isHidden = true
        button.isAccessibilityElement = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    lazy var cakeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cakeImage")
        image.isAccessibilityElement = true
        image.accessibilityLabel = "Ícone de bolo com um rolo e uma cesta de frutas abaixo."
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.titleLabel?.font = Fonts.h4
        button.titleLabel?.textColor = Colors.background
        button.backgroundColor = Colors.primary
        button.layer.cornerRadius = 18
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Okey"
        button.accessibilityHint = "Volta à tela inicial"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func setupConstraints() {
        self.addSubview(titleLabel)
        self.addSubview(closeButton)
        self.addSubview(cakeImage)
        self.addSubview(okButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            cakeImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.65),
            cakeImage.heightAnchor.constraint(equalTo: cakeImage.widthAnchor, multiplier: 0.7212),
            cakeImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cakeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            okButton.widthAnchor.constraint(equalToConstant: 160),
            okButton.heightAnchor.constraint(equalToConstant: 40),
            okButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

}
