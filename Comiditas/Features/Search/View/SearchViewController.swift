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

    let headers = ["Populares", "Outros"]
    let popular = ["Massas", "Rápidas", "Vegetariano", "Doces"]
    let others = ["Bolos e tortas", "Frutos do mar", "Carnes", "Peixes",
                  "Saladas", "Aves", "Vegano", "Lacfree", "Sopas",
                  "Molhos", "Bebidas", "Glúten free", "Fit", "Fáceis"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        setupTableView()
    }

    override func loadView() {
        super.loadView()
        self.view = contentView
        navigationItem.largeTitleDisplayMode = .never
        title = "Pesquisar receitas"
    }

    func setupVIP() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    func setupTableView() {
        contentView.tagsView.collectionView.delegate = self
        contentView.tagsView.collectionView.dataSource = self
    }
}

extension SearchViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == .zero {
            return popular.count
        }

        return others.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TagsCollectionViewCell",
            for: indexPath
        ) as? TagsCollectionViewCell else { return UICollectionViewCell() }

        cell.label.text = (indexPath.section == .zero) ? popular[indexPath.row] : others[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == .zero {
            return CGSize(
                width: popular[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: Fonts.h5]).width + 13,
                height: 40
            )
        }
        return CGSize(
            width: others[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: Fonts.h5]).width + 13,
            height: 40
        )
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "TagsHeaderCollectionReusableView",
            for: indexPath
        ) as? TagsHeaderCollectionReusableView else {
            return UICollectionReusableView()
        }
        headerView.headerLabel.text = headers[indexPath.section]
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicou")
    }
}

extension SearchViewController: SearchViewControllerProtocol {}
