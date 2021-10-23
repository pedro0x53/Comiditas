//
//  PreparationCoordinatorProtocol.swift
//  Comiditas
//
//  Created by Alley Pereira on 22/09/21.
//

import Foundation
import UIKit

protocol PreparationCoordinatorProtocol {
    func coordinateBack()
    func presentDidModal(
        with image: UIImage?,
        title: String,
        description: String,
        closeButtonIsHidden: Bool,
        okAction: @escaping () -> Void
    )
}

class PreparationCoordinator: Coordinator {
    let navigationController: UINavigationController
    var recipe: RecipeJson?
    var image: UIImage?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let recipe = recipe {
            let preparationViewController = PreparationViewController()
            preparationViewController.recipe = recipe
            preparationViewController.image = image
            preparationViewController.coordinator = self
            navigationController.pushViewController(preparationViewController, animated: true)
        }
    }
}

extension PreparationCoordinator: PreparationCoordinatorProtocol {
    func coordinateBack() {
        navigationController.popViewController(animated: true)
    }

    func presentDidModal(
        with image: UIImage?,
        title: String,
        description: String,
        closeButtonIsHidden: Bool,
        okAction: @escaping () -> Void
    ) {
        let finishCoordinator = ModalCoordinator(navigationController: navigationController)
        finishCoordinator.image = image ?? UIImage(named: "cakeImage")!
        finishCoordinator.title = title
        finishCoordinator.description = description
        finishCoordinator.closeButtonIsHidden = closeButtonIsHidden
        finishCoordinator.okAction = okAction
        coordinate(to: finishCoordinator)
    }
}
