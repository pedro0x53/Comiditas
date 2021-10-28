//
//  SettingsCoordinator.swift
//  Comiditas
//
//  Created by Brena Amorim on 28/10/21.
//

import UIKit

protocol SettingsCoordinatorProtocol: AnyObject {
//    func navigateToOverview(recipe: RecipeJson)
}

class SettingsCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let settingsViewController = SettingsViewController()
        settingsViewController.coordinator = self
        navigationController.pushViewController(settingsViewController, animated: true)
    }
}

extension SettingsCoordinator: SettingsCoordinatorProtocol {
    func coordinate() {
        print("coordinate")
    }
}
