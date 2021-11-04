//
//  OverviewCoordinator.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//

import UIKit

protocol OverviewCoordinatorProtocol {
    func coordinateToSteps(recipe: RecipeJson, image: UIImage?, currentStep: Int)
    func shareText(content: String, animated: Bool, completion: (() -> Void)?)
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

    func coordinateToSteps(recipe: RecipeJson, image: UIImage?, currentStep: Int = 0) {
        let stepsCoordinator = StepsCoordinator(navigationController: navigationController)
        stepsCoordinator.recipe = recipe
        stepsCoordinator.image = image
        coordinate(to: stepsCoordinator)
    }

    func shareText(content: String, animated: Bool = true, completion: (() -> Void)? = nil) {
        let textToShare = [content]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.airDrop, .openInIBooks]
        navigationController.present(activityViewController, animated: animated, completion: completion)
    }
}
