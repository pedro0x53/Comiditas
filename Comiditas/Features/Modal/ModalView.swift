//
//  FinishModalView.swift
//  Comiditas
//
//  Created by Brena Amorim on 21/09/21.
//

import UIKit

protocol ModalViewDelegate: AnyObject {
    func didPressOK()
    func didCancel()
}

class ModalView: UIView {

    weak var delegate: ModalViewDelegate?

    let closeButtonIsHidden: Bool

    init(closeButtonIsHidden: Bool) {
        self.closeButtonIsHidden = closeButtonIsHidden
        super.init(frame: .zero)

        setupView()
        setupConstraints()

        closeButton.isHidden = closeButtonIsHidden
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var modalView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = Colors.secondary
        view.layer.borderColor = Colors.primary.cgColor
        view.layer.borderWidth = 1.5
        view.layer.borderColor = Colors.primary.cgColor
        view.isAccessibilityElement = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h3
        label.textColor = Colors.textDark
        label.textAlignment = .center
        label.isAccessibilityElement = true
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h6
        label.textColor = Colors.textDark
        label.isAccessibilityElement = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.isAccessibilityElement = true
        return image
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.isAccessibilityElement = true
        button.accessibilityLabel =  ModalLocalizable.close.text
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()

    @objc func cancelAction() {
        self.delegate?.didCancel()
    }

    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ok", for: .normal)
        button.titleLabel?.font = Fonts.h4Bold
        button.titleLabel?.textColor = Colors.background
        button.backgroundColor = Colors.primary
        button.layer.cornerRadius = 18
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Okey"
        button.addTarget(self, action: #selector(didFinishAction), for: .touchUpInside)
        return button
    }()

    @objc func didFinishAction() {
        self.delegate?.didPressOK()
    }

    func loadData(image: UIImage, title: String, description: String) {
        self.imageView.image = image
        self.titleLabel.text = title
        self.titleLabel.accessibilityLabel = title
        self.descriptionLabel.text = description
        self.descriptionLabel.accessibilityLabel = description
    }
}

extension ModalView: BaseViewProtocol {
    func setupView() {
        self.backgroundColor = .black.withAlphaComponent(0.3)

        self.addSubview(modalView)
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(closeButton)
        self.addSubview(imageView)
        self.addSubview(okButton)

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            modalView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            modalView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            modalView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            closeButton.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30),

            titleLabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -24),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -15),

            imageView.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -15),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.55),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.6),
            imageView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor),

            okButton.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -16),
            okButton.widthAnchor.constraint(equalToConstant: 155),
            okButton.heightAnchor.constraint(equalToConstant: 35),
            okButton.centerXAnchor.constraint(equalTo: modalView.centerXAnchor)
        ])
    }
}
