//
//  SearchCoordinator.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 28/10/21.
//

import UIKit

protocol SearchCoordinatorProtocol: AnyObject {
    func navigateToOverview(recipe: RecipeJson)
}

class SearchCoordinator: Coordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let searchViewController = SearchViewController()
        searchViewController.coordinator = self
        navigationController.pushViewController(searchViewController, animated: true)
    }
}

extension SearchCoordinator: SearchCoordinatorProtocol {
    func navigateToOverview(recipe: RecipeJson) {
        let overviewCoordinator = OverviewCoordinator(navigationController: navigationController)
        overviewCoordinator.recipe = recipe
        coordinate(to: overviewCoordinator)
    }
}
