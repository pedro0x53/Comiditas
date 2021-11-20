//
//  StepsCoordinator.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit

protocol StepsCoordinatorProtocol: NSObjectProtocol, Coordinator {
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func presentDidModal(
        with image: UIImage?,
        title: String,
        description: String,
        closeButtonIsHidden: Bool,
        okAction: @escaping () -> Void
    )
}

class StepsCoordinator: NSObject, StepsCoordinatorProtocol {

    let navigationController: UINavigationController
    var recipe: RecipeJson?
    var image: UIImage?

    let showedOnboarding = UserDefaults.standard.bool(forKey: "showedOnboardingKey")

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let recipe = recipe {
            let stepsViewController = StepsViewController()
            stepsViewController.modalPresentationStyle = .fullScreen
            stepsViewController.recipe = recipe
            stepsViewController.image = image
            stepsViewController.coordinator = self
            navigationController.present(stepsViewController, animated: true)

            if !showedOnboarding {
                let onboardingCoordinator = OnboardingCoordinator(viewController: stepsViewController)
                coordinate(to: onboardingCoordinator)
            }
        }

    }

    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.presentedViewController?.dismiss(animated: animated, completion: completion)
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
