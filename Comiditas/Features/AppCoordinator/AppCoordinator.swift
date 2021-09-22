//
//  AppCoordinator.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Colors.secondary
        appearance.titleTextAttributes = [.foregroundColor: Colors.primary]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.primary]

        navigationController.navigationBar.tintColor = Colors.primary
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let feedCoodinator = FeedCoordinator(navigationController: navigationController)
        coordinate(to: feedCoodinator)
    }
}
