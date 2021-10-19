//
//  FinishViewController.swift
//  Comiditas
//
//  Created by Brena Amorim on 21/09/21.
//

import UIKit

class ModalViewController: UIViewController {

    let associatedView: ModalView = ModalView()

    var coordinator: ModalCoordinator?

    let okAction: () -> Void

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

    public init(image: UIImage, title: String, okAction: @escaping () -> Void) {
        self.okAction = okAction
        super.init(nibName: nil, bundle: nil)
        associatedView.loadData(image: image, title: title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ModalViewController: ModalViewDelegate {
    func didPressOK() {
        okAction()
        self.coordinator?.cancelDismiss()
    }

    func didCancel() {
        self.coordinator?.cancelDismiss()
    }
}
