//
//  SettingsViewController.swift
//  Comiditas
//
//  Created by Brena Amorim on 27/10/21.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewDelegate {

    let associatedView: SettingsView = SettingsView()

    override func loadView() {
        super.loadView()
        associatedView.delegate = self
        self.view = associatedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.backgroundColor = .white
        title = SettingsLocalizable.title.text
    }
}

extension SettingsViewController {
    enum SettingsSection: Int {
        case stepsSettings = 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        switch section {
        case .stepsSettings:
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .stepsSettings:
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SettingsStepsTableViewCell.identifier) as? SettingsStepsTableViewCell
            else {
                let cell = SettingsStepsTableViewCell(style: .default,
                                                      reuseIdentifier: SettingsStepsTableViewCell.identifier)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
                configureSwitchTableCell(cell: cell, index: indexPath)
                return cell
            }
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            configureSwitchTableCell(cell: cell, index: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = SettingsSection(rawValue: section) else { return nil }
        switch section {
        case .stepsSettings:
            guard let header = tableView.dequeueReusableHeaderFooterView(
                    withIdentifier: SettingsHeaderView.identifier) as? SettingsHeaderView
            else {
                let header = SettingsHeaderView()
                header.configure(titleText: SettingsLocalizable.headerStepsTitle.text)
                return header
            }

            header.configure(titleText: SettingsLocalizable.headerStepsTitle.text)
            return header
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        switch section {
        case .stepsSettings:
            return 52
        }
    }

}

// Setting switches actions
extension SettingsViewController {
    func configureSwitchTableCell(cell: SettingsStepsTableViewCell, index: IndexPath) {
        switch index.row {
        case 0:
            cell.configure(text: SettingsLocalizable.voiceCommands.text)
            cell.switchButton.addTarget(self, action: #selector(voiceCommands), for: .valueChanged)
        case 1:
            cell.configure(text: SettingsLocalizable.lockscreen.text)
            cell.switchButton.addTarget(self, action: #selector(lockscreen), for: .valueChanged)
        case 2:
            cell.configure(text: SettingsLocalizable.notifications.text)
            cell.switchButton.addTarget(self, action: #selector(notifications), for: .valueChanged)
        default:
            print("Caso não tratado.")
        }
    }

    @objc func voiceCommands(target: UISwitch) {
        if target.isOn {
            print("The Switch is voiceCommands is on")
        }
    }

    @objc func lockscreen() {
        print("The Switch is lockscreen")
    }

    @objc func notifications() {
        print("The Switch is notifications")
    }
}
