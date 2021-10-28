//
//  SettingsViewController.swift
//  Comiditas
//
//  Created by Brena Amorim on 27/10/21.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewDelegate {

    var coordinator: SettingsCoordinatorProtocol?
    let associatedView: SettingsView = SettingsView()

    override func loadView() {
        super.loadView()
        associatedView.delegate = self
        self.view = associatedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        title = "Configurações"
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
                cell.configure(text: "testando table", switchButtonIsOn: true)
                return cell
            }
            cell.configure(text: "testando table", switchButtonIsOn: true)
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
                header.configure(titleText: "Passo a passo interativo")
                return header
            }

            header.configure(titleText: "Passo a passo interativo")
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

//extension SettingsViewController: SettingsViewDelegate {
    //implementar a funcao do delegate
//}
