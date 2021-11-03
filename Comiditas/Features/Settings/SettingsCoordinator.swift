//
//  SettingsCoordinator.swift
//  Comiditas
//
//  Created by Brena Amorim on 28/10/21.
//

import UIKit

class SettingsCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let settingsViewController = SettingsViewController()
        navigationController.pushViewController(settingsViewController, animated: true)
    }
}
