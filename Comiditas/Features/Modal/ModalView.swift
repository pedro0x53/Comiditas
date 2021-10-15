//
//  FinishModalView.swift
//  Comiditas
//
//  Created by Brena Amorim on 21/09/21.
//

import UIKit

class ModalView: UIView {

    weak var delegate: ModalViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var modalView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = Colors.secondary
        view.layer.borderWidth = 1.5
        view.layer.borderColor = Colors.primary.cgColor
        view.isAccessibilityElement = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h3
        label.textColor = Colors.primary
        label.isAccessibilityElement = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.isAccessibilityElement = true
        image.accessibilityLabel = ModalLocalizable.imageDescriptionAcessibility.text
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.isAccessibilityElement = true
        button.accessibilityLabel =  ModalLocalizable.close.text
        button.translatesAutoresizingMaskIntoConstraints = false
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didFinishAction), for: .touchUpInside)
        return button
    }()

    @objc func didFinishAction() {
        self.delegate?.didPressOK()
    }

    func loadData(image: UIImage, title: String) {
        self.imageView.image = image
        self.titleLabel.text = title
        self.titleLabel.accessibilityLabel = title
    }
}

extension ModalView: BaseViewProtocol {
    func setupView() {
        self.backgroundColor = .black.withAlphaComponent(0.3)

        self.addSubview(modalView)
        self.addSubview(titleLabel)
        self.addSubview(closeButton)
        self.addSubview(imageView)
        self.addSubview(okButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            modalView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            modalView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            modalView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            modalView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            modalView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height * 0.5)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -8),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width*0.65),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.7212),
            imageView.centerXAnchor.constraint(equalTo: modalView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: modalView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -16),
            okButton.widthAnchor.constraint(equalToConstant: 160),
            okButton.heightAnchor.constraint(equalToConstant: 40),
            okButton.centerXAnchor.constraint(equalTo: modalView.centerXAnchor)
        ])
    }
}

protocol ModalViewDelegate: AnyObject {
    func didPressOK()
    func didCancel()
}
