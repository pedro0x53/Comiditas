//
//  OverviewCoordinator.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//

import UIKit

protocol OverviewCoordinatorProtocol {
    func coordinateToSteps(recipe: RecipeJson, currentStep: Int)
}

class OverviewCoordinator: Coordinator {
    let navigationController: UINavigationController
    var recipe: RecipeJson?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let recipe = recipe {
            let overviewViewController = OverviewViewController(recipe: recipe)
            overviewViewController.coordinator = self
            navigationController.pushViewController(overviewViewController, animated: true)
        }
    }
}

extension OverviewCoordinator: OverviewCoordinatorProtocol {
    func coordinateToSteps(recipe: RecipeJson, currentStep: Int = 0) {
        let preparationCoordinator = PreparationCoordinator(navigationController: navigationController)
        preparationCoordinator.recipe = recipe
        coordinate(to: preparationCoordinator)
    }
}
