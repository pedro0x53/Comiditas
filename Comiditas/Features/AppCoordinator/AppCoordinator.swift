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
        appearance.backgroundColor = Colors.background
        appearance.titleTextAttributes = [.foregroundColor: Colors.primary]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.primary, .font: Fonts.title]

        navigationController.navigationBar.tintColor = Colors.primary
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage(named: "")

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let settingsCoodinator = SettingsCoordinator(navigationController: navigationController)
             coordinate(to: settingsCoodinator)

//        let feedCoodinator = FeedCoordinator(navigationController: navigationController)
//        coordinate(to: feedCoodinator)
    }
}
