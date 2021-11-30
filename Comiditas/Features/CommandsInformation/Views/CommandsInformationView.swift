//
//  InformationView.swift
//  Comiditas
//
//  Created by Alley Pereira on 29/11/21.
//

import UIKit

protocol InformationButtonDelegate: AnyObject {
    func dismissButton()
}

class CommandsInformationView: UIView {

    weak var delegate: InformationButtonDelegate?

    lazy var informationTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            CommandsInformationTableViewCell.self,
            forCellReuseIdentifier: CommandsInformationTableViewCell.identifier
        )
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(
            systemName: "xmark.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .bold
            )
        )
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primary
        bottomAnchor.isAccessibilityElement = true
        button.accessibilityLabel = StepsLocalizable.close.text
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var infoSpeechLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h3
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.textDark
        label.text = "Comandos de voz"
        label.isAccessibilityElement = true
        return label
    }()

    lazy var infoSpeechImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isAccessibilityElement = false
        imageView.image = UIImage(named: "megafone-info")
        return imageView
    }()

    // MARK: - Object LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Setup
   private func setupView() {

        self.backgroundColor = Colors.secondary
        self.addSubview(informationTableView)
        self.addSubview(closeButton)
        self.addSubview(infoSpeechImageView)
        self.addSubview(infoSpeechLabel)
    }

    private func setupConstraints() {

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([

            closeButton.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 10
            ),
            closeButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -10
            ),
            closeButton.heightAnchor.constraint(
                equalToConstant: 40
            ),

            infoSpeechImageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 10
            ),
            infoSpeechImageView.topAnchor.constraint(
                equalTo: self.closeButton.bottomAnchor,
                constant: -20
            ),
            infoSpeechImageView.widthAnchor.constraint(
                equalToConstant: UIScreen.main.bounds.width * 0.15
            ),
            infoSpeechImageView.heightAnchor.constraint(
                equalTo: infoSpeechImageView.widthAnchor
            ),

            infoSpeechLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            infoSpeechLabel.centerXAnchor.constraint(
                equalTo: self.centerXAnchor
            ),
            infoSpeechLabel.centerYAnchor.constraint(
                equalTo: infoSpeechImageView.centerYAnchor
            ),

            informationTableView.topAnchor.constraint(
                equalTo: infoSpeechLabel.bottomAnchor,
                constant: 30
            ),
            informationTableView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor
            ),
            informationTableView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            informationTableView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            )
        ])
    }

    // MARK: Actions
    @objc func closeButtonAction() {
        self.delegate?.dismissButton()
    }

}
