//
//  FeedViewController.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

class FeedViewController: UIViewController {
    var coordinator: FeedCoordinatorProtocol?
    let contentView = FeedView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }

    override func loadView() {
        self.view = contentView
    }

    func setupViewController() {
        contentView.delegate = self
        title = "Comiditas"
    }
}

extension FeedViewController: FeedViewProtocol {

}
