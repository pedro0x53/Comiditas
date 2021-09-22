//
//  PreparationCoordinatorProtocol.swift
//  Comiditas
//
//  Created by Alley Pereira on 22/09/21.
//

import Foundation
import UIKit

protocol PreparationCoordinatorProtocol {
    func coordinateBack(recipe: RecipeJson, currentStep: Int)
}

class PreparationCoordinator: Coordinator {
    let navigationController: UINavigationController
    var recipe: RecipeJson?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let recipe = recipe {
            let preparationViewController = PreparationViewController()
            preparationViewController.recipe = recipe
            preparationViewController.coordinator = self
            navigationController.pushViewController(preparationViewController, animated: true)
        }
    }
}

extension PreparationCoordinator: PreparationCoordinatorProtocol {
    func coordinateBack(recipe: RecipeJson, currentStep: Int) {
        navigationController.popViewController(animated: true)
    }
}
