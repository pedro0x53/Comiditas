//
//  SettingsViewController.swift
//  Comiditas
//
//  Created by Brena Amorim on 27/10/21.
//

import UIKit

protocol SettingsDisplayLogic: AnyObject {
    func displayVoiceCommandsToggle(viewModel: VoiceCommands.ViewModel)
    func displayLockscreenToggle(viewModel: Lockscreen.ViewModel)
    func displayNotificationsToggle(viewModel: Notifications.ViewModel)
}

class SettingsViewController: UIViewController, SettingsViewDelegate {

    let associatedView: SettingsView = SettingsView()
    var coordinator: SettingsCoordinator?
    var interactor: SettingsInteractorProtocol?
    var stepsState: [Bool] = [false, false, false]

    override func loadView() {
        super.loadView()
        associatedView.delegate = self
        self.view = associatedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupVIP()
    }

    func setupVIP() {
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter()

        self.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = self
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
            makeRequests()
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SettingsStepsTableViewCell.identifier) as? SettingsStepsTableViewCell
            else {
                let cell = SettingsStepsTableViewCell(style: .default,
                                                      reuseIdentifier: SettingsStepsTableViewCell.identifier)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
                cell.selectedBackgroundView?.backgroundColor = .clear

                configureSwitchTableCell(cell: cell, index: indexPath)
                return cell
            }
            cell.selectedBackgroundView?.backgroundColor = .clear
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
            return 56
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("celula selecionada!")

        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        guard let cell = tableView.cellForRow(at: indexPath) as? SettingsStepsTableViewCell else { return }

        if UIAccessibility.isVoiceOverRunning {
            switch section {
            case .stepsSettings:
                switch indexPath.row {
                case 0:
                    cell.switchButton.isOn.toggle()
                    voiceCommands(target: cell.switchButton)
                    let switchButton = cell.switchButton.isOn ? "Ativado" : "Desativado"
                    cell.accessibilityLabel = [SettingsLocalizable.voiceCommands.text,
                                               switchButton].joined(separator: " , ")
                case 1:
                    cell.switchButton.isOn.toggle()
                    lockscreen(target: cell.switchButton)
                    let switchButton = cell.switchButton.isOn ? "Ativado" : "Desativado"
                    cell.accessibilityLabel = [SettingsLocalizable.lockscreen.text,
                                               switchButton].joined(separator: " , ")
                case 2:
                    cell.switchButton.isOn.toggle()
                    notifications(target: cell.switchButton)
                    let switchButton = cell.switchButton.isOn ? "Ativado" : "Desativado"
                    cell.accessibilityLabel = [SettingsLocalizable.notifications.text,
                                               switchButton].joined(separator: " , ")
                default:
                    break
                }
            }
        }
    }

}

// Setting switches
extension SettingsViewController {

    func makeRequests() {
        let requestVC = VoiceCommands.Request(voiceCommandsEnable: true)
        interactor?.request(isChange: false, voiceCommandRequest: requestVC)

        let requestLS = Lockscreen.Request(lockscreenEnable: true)
        interactor?.request(isChange: false, lockscreenRequest: requestLS)

        let requestN = Notifications.Request(notificationsEnable: true)
        interactor?.request(isChange: false, notificationsRequest: requestN)
    }

    func configureSwitchTableCell(cell: SettingsStepsTableViewCell, index: IndexPath) {
        switch index.row {
        case 0:
            cell.isUserInteractionEnabled = true
            cell.switchButton.isOn = stepsState[0]
            cell.configure(text: SettingsLocalizable.voiceCommands.text)
            configureAcessibility(cell: cell, title: SettingsLocalizable.voiceCommands.text)
            cell.switchButton.addTarget(self, action: #selector(voiceCommands), for: .valueChanged)
        case 1:
            cell.switchButton.isOn = stepsState[1]
            cell.configure(text: SettingsLocalizable.lockscreen.text)
            configureAcessibility(cell: cell, title: SettingsLocalizable.lockscreen.text)
            cell.switchButton.addTarget(self, action: #selector(lockscreen), for: .valueChanged)
        case 2:
            cell.switchButton.isOn = stepsState[2]
            cell.configure(text: SettingsLocalizable.notifications.text)
            configureAcessibility(cell: cell, title: SettingsLocalizable.notifications.text)
            cell.switchButton.addTarget(self, action: #selector(notifications), for: .valueChanged)
        default:
            print("Caso não tratado.")
        }
    }

    @objc func voiceCommands(target: UISwitch) {
        let request = VoiceCommands.Request(voiceCommandsEnable: target.isOn)
        interactor?.request(isChange: true, voiceCommandRequest: request)
    }

    @objc func lockscreen(target: UISwitch) {
        let request = Lockscreen.Request(lockscreenEnable: target.isOn)
        interactor?.request(isChange: true, lockscreenRequest: request)
    }

    @objc func notifications(target: UISwitch) {
        let request = Notifications.Request(notificationsEnable: target.isOn)
        interactor?.request(isChange: true, notificationsRequest: request)
    }

}

// Accessibility configuration
extension SettingsViewController {
    func configureAcessibility(cell: SettingsStepsTableViewCell, title: String) {
        let switchButton = cell.switchButton.isOn ? "Ativado" : "Desativado"

        cell.isAccessibilityElement = true
        cell.accessibilityTraits = .none
        cell.shouldGroupAccessibilityChildren = true
        cell.accessibilityLabel = [title, switchButton].joined(separator: " , ")
        cell.accessibilityHint = "Toque duas vezes para alternar a configuração"
    }
}

// VIP Connection: Presenter->View
extension SettingsViewController: SettingsDisplayLogic {
    func displayVoiceCommandsToggle(viewModel: VoiceCommands.ViewModel) {
        stepsState[0] = viewModel.voiceCommandsEnabled
    }

    func displayLockscreenToggle(viewModel: Lockscreen.ViewModel) {
        stepsState[1] = viewModel.lockscreenEnabled
    }

    func displayNotificationsToggle(viewModel: Notifications.ViewModel) {
        stepsState[2] = viewModel.notificationsEnabled
    }
}
