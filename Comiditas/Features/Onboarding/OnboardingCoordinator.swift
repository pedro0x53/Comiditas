//
//  OnboardingCoordinator.swift
//  Comiditas
//
//  Created by Alley Pereira on 18/11/21.
//

import Foundation
import UIKit

class OnboardingCoordinator: Coordinator {

    let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func start() {
        let onboardingViewController = OnboardingViewController()
        onboardingViewController.coordinator = self
        onboardingViewController.modalPresentationStyle = .overFullScreen
        viewController.present(onboardingViewController, animated: true, completion: nil)
    }

}
