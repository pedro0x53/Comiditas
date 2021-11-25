//
//  FinishModalCoordinator.swift
//  Comiditas
//
//  Created by Pedro Sousa on 22/09/21.
//

import UIKit

protocol ModalCoordinatorProtocol: AnyObject {
    func didTapOk()
    func cancelDismiss()
}

class ModalCoordinator: Coordinator {
    let navigationController: UINavigationController
    private var modalVC: ModalViewController?

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

        self.modalVC = viewController

        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        viewController.coordinator = self
        navigationController.visibleViewController?.present(viewController, animated: true)
    }
}

extension ModalCoordinator: ModalCoordinatorProtocol {
    func didTapOk() {
        self.navigationController.visibleViewController?.presentedViewController?.dismiss(animated: true)
    }

    func cancelDismiss() {
        self.navigationController.visibleViewController?.presentedViewController?.dismiss(animated: true)
    }
}
