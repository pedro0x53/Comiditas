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
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let feedCoodinator = FeedCoordinator(navigationController: navigationController)
        coordinate(to: feedCoodinator)
    }
}
