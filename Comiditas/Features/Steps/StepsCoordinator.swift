//
//  StepsCoordinator.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit

protocol StepsCoordinatorProtocol {
    func coordinateBack()
    func presentDidModal(
        with image: UIImage?,
        title: String,
        description: String,
        closeButtonIsHidden: Bool,
        okAction: @escaping () -> Void
    )
}

class StepsCoordinator: Coordinator {

    let navigationController: UINavigationController
    var recipe: RecipeJson?
    var image: UIImage?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let recipe = recipe {
            let stepsViewController = StepsViewController()
            stepsViewController.recipe = recipe
            stepsViewController.image = image
            stepsViewController.coordinator = self
            navigationController.modalPresentationStyle = .automatic
            navigationController.present(stepsViewController, animated: true)
        }
    }
}

extension StepsCoordinator: StepsCoordinatorProtocol {
    func coordinateBack() {
        navigationController.popViewController(animated: true)
    }

    func presentDidModal(
        with image: UIImage?,
        title: String,
        description: String,
        closeButtonIsHidden: Bool,
        okAction: @escaping () -> Void) {

        let finishCoordinator = ModalCoordinator(navigationController: navigationController)
        finishCoordinator.image = image ?? UIImage(named: "cakeImage")
        finishCoordinator.title = title
        finishCoordinator.description = description
        finishCoordinator.closeButtonIsHidden = closeButtonIsHidden
        finishCoordinator.okAction = okAction
        coordinate(to: finishCoordinator)
    }

}
