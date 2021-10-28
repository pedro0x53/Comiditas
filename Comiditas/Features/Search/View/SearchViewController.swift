//
//  SearchViewController.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 28/10/21.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {}

class SearchViewController: UIViewController {
    var coordinator: SearchCoordinatorProtocol?
    let contentView = SearchView(frame: UIScreen.main.bounds)
    var interactor: SearchInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
    }

    override func loadView() {
        super.loadView()
        self.view = contentView
    }

    func setupVIP() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension SearchViewController: SearchViewControllerProtocol {}
