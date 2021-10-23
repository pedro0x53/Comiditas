//
//  FinishViewController.swift
//  Comiditas
//
//  Created by Brena Amorim on 21/09/21.
//

import UIKit

class ModalViewController: UIViewController {

    lazy var associatedView: ModalView = ModalView(closeButtonIsHidden: closeButtonIsHidden)

    var coordinator: ModalCoordinator?

    let okAction: () -> Void

    let closeButtonIsHidden: Bool

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

    public init(
        image: UIImage,
        title: String,
        description: String,
        closeButtonIsHidden: Bool,
        okAction: @escaping () -> Void
    ) {
        self.okAction = okAction
        self.closeButtonIsHidden = closeButtonIsHidden
        super.init(nibName: nil, bundle: nil)
        associatedView.loadData(image: image, title: title, description: description)
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
