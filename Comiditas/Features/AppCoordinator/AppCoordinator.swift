//
//  AppCoordinator.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    let navigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        navigationController.navigationBar.prefersLargeTitles = true

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: Colors.primary, .font: Fonts.title]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.primary, .font: Fonts.title]

        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.layoutIfNeeded()
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let feedCoodinator = FeedCoordinator(navigationController: navigationController)
        coordinate(to: feedCoodinator)
    }
}
