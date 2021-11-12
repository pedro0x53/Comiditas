//
//  FeedCoordinator.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

protocol FeedCoordinatorProtocol: AnyObject {
    func navigateToOverview(recipe: RecipeJson)
    func navigateToSearch()
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
    func navigateToSearch() {
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        coordinate(to: searchCoordinator)
    }

    func navigateToOverview(recipe: RecipeJson) {
        let overviewCoordinator = OverviewCoordinator(navigationController: navigationController)
        overviewCoordinator.recipe = recipe
        coordinate(to: overviewCoordinator)
    }
}
