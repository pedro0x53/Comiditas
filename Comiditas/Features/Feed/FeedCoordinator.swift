//
//  FeedCoordinator.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

protocol FeedCoordinatorProtocol: AnyObject {
    func coordinateToTabBar()
}

class FeedCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedViewController = FeedViewController()
        feedViewController.coordinator = self
        navigationController.pushViewController(feedViewController, animated: true)
    }
}

extension FeedCoordinator: FeedCoordinatorProtocol {
    func coordinateToTabBar() {
        // Todo: Push para a tela do pedro
    }
}
