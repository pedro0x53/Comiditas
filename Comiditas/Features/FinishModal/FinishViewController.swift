//
//  FinishViewController.swift
//  Comiditas
//
//  Created by Brena Amorim on 21/09/21.
//

import UIKit

class FinishViewController: UIViewController {

    let associatedView: FinishModalView = FinishModalView()

    var coordinator: FinishModalCoordinator?

    override func loadView() {
        super.loadView()
        self.associatedView.delegate = self
        self.view = associatedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true
        definesPresentationContext = true
    }
}

extension FinishViewController: FinishViewDelegate {
    func didFinishRecipe() {
        self.coordinator?.didFinishRecipe()
    }

    func didCancel() {
        self.coordinator?.cancelDismiss()
    }
}
