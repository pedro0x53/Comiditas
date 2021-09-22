//
//  FinishModalCoordinator.swift
//  Comiditas
//
//  Created by Pedro Sousa on 22/09/21.
//

import UIKit

protocol FinishModalCoordinatorProtocol: AnyObject {
    func didFinishRecipe()
    func cancelDismiss()
}

class FinishModalCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let finishViewController = FinishViewController()
        finishViewController.modalPresentationStyle = .overCurrentContext
        finishViewController.modalTransitionStyle = .crossDissolve
        finishViewController.coordinator = self
        navigationController.present(finishViewController, animated: true)
    }
}

extension FinishModalCoordinator: FinishModalCoordinatorProtocol {
    func didFinishRecipe() {
        navigationController.dismiss(animated: false)
        navigationController.popViewController(animated: true)
    }

    func cancelDismiss() {
        navigationController.dismiss(animated: true)
    }
}
