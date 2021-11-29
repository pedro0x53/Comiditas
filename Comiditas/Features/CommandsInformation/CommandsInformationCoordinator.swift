//
//  CommandsInformationCoordinator.swift
//  Comiditas
//
//  Created by Alley Pereira on 29/11/21.
//

import Foundation
import UIKit

class CommandsInformationCoordinator: Coordinator {

    let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func start() {
        let informationViewController = CommandsInformationViewController()
        informationViewController.coordinator = self
        informationViewController.modalPresentationStyle = .pageSheet
        viewController.present(informationViewController, animated: true, completion: nil)
    }
}
