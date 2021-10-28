//
//  SettingsStepsCellTableViewCell.swift
//  Comiditas
//
//  Created by Brena Amorim on 27/10/21.
//

import UIKit

class SettingsStepsTableViewCell: UITableViewCell {

    public static let identifier: String = "SettingsStepsCellIdentifier"

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Config teste"
        label.textColor = Colors.textDark
        label.font = Fonts.h6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var switchButton: UISwitch = {
       let button = UISwitch()
        button.onTintColor = Colors.primary
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text: String, switchButtonIsOn: Bool) {
        label.text = text
        switchButton.setOn(switchButtonIsOn, animated: true)
    }

    @objc func stateChanged() {
       if switchButton.isOn {
           print("The Switch is On")
       } else {
            print("The Switch is Off")
       }
   }

    func setupView() {
        contentView.addSubview(label)
        contentView.addSubview(switchButton)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            switchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            switchButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
