//
//  FinishModalCoordinator.swift
//  Comiditas
//
//  Created by Pedro Sousa on 22/09/21.
//

import UIKit

protocol ModalCoordinatorProtocol: AnyObject {
    func didFinishRecipe()
    func cancelDismiss()
}

class ModalCoordinator: Coordinator {
    let navigationController: UINavigationController

    var image: UIImage?
    var title: String?
    var description: String?
    var okAction: (() -> Void)?
    var closeButtonIsHidden: Bool = true

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        guard let image = image,
                let title = title,
                let description = description,
                let okAction = okAction else { return }

        let viewController = ModalViewController(
            image: image,
            title: title,
            description: description,
            closeButtonIsHidden: closeButtonIsHidden,
            okAction: okAction
        )
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        viewController.coordinator = self
        navigationController.present(viewController, animated: true)
    }
}

extension ModalCoordinator: ModalCoordinatorProtocol {
    func didFinishRecipe() {
        navigationController.dismiss(animated: false)
        navigationController.popViewController(animated: true)
    }

    func cancelDismiss() {
        navigationController.dismiss(animated: true)
    }
}
