//
//  SearchViewController.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 28/10/21.
//

import UIKit

protocol SearchViewControllerProtocol: AnyObject {
    func displayRecipes(viewModel: Search.ViewModel)
}

class SearchViewController: UIViewController, SearchViewControllerProtocol {
    var coordinator: SearchCoordinatorProtocol?
    let contentView = SearchView(frame: UIScreen.main.bounds)
    var interactor: SearchInteractorProtocol?
    var recipes: [RecipeJson] = []

    let headers = ["Populares", "Outros"]
    let popular = ["Massas", "Rápidas", "Vegetariano", "Doces"]
    let others = ["Fit", "Aves", "Bolos e tortas", "Frutos do mar", "Carnes", "Peixes",
                  "Saladas", "Vegano", "Lacfree", "Sopas",
                  "Molhos", "Bebidas", "Glúten free", "Fáceis", "Mexicana"]

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

    func displayRecipes(viewModel: Search.ViewModel) {
        if viewModel.recipes.count != 0 {
            recipes = viewModel.recipes
            self.contentView.tableView.reloadData()
            contentView.searchEmptyView.isHidden = true
        } else {
            contentView.tagsView.isHidden = true
            contentView.tableView.isHidden = true
            contentView.searchEmptyView.isHidden = false
        }
    }

    func setupVIP() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        contentView.searchBar.delegate = self
    }

    func setupTableView() {
        contentView.tagsView.collectionView.delegate = self
        contentView.tagsView.collectionView.dataSource = self

        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
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
                width: popular[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: Fonts.h5]).width + 25,
                height: 40
            )
        }
        return CGSize(
            width: others[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: Fonts.h5]).width + 25,
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
        contentView.tagsView.isUserInteractionEnabled = true
        contentView.tagsView.isHidden = true

        if indexPath.section == .zero {
            contentView.buttonTag.setTitle(popular[indexPath.row], for: .normal)
            interactor?.searchTagRecipes(search: popular[indexPath.row])
        } else {
            contentView.buttonTag.setTitle(others[indexPath.row], for: .normal)
            interactor?.searchTagRecipes(search: others[indexPath.row])
        }

        contentView.buttonTag.isHidden = false
        contentView.tableView.isHidden = false
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RecipesTableViewCell",
            for: indexPath
        ) as? RecipesTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        if let url = URL(string: recipes[indexPath.row].imageURL) {
            cell.recipeImageView.load(url: url)
        }

        cell.titleLabel.text = recipes[indexPath.row].name
        cell.titleLabel.accessibilityTraits = .staticText
        cell.titleLabel.accessibilityLabel = recipes[indexPath.row].name

        cell.labelPortion.text = "\(recipes[indexPath.row].servings) porções"
        cell.labelPortion.accessibilityTraits = .staticText
        cell.labelPortion.accessibilityLabel = "\(recipes[indexPath.row].servings) porções"

        let time = Time.secondsToHoursMinutesSeconds(seconds: recipes[indexPath.row].prepTime)
        cell.labelTime.text = Time.getString(for: time).accessible
        cell.labelTime.accessibilityTraits = .staticText
        cell.labelTime.accessibilityLabel = Time.getString(for: time).accessible

        cell.labelStar.text = "\(recipes[indexPath.row].rate).0"
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToOverview(recipe: recipes[indexPath.row])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count != 0 {
            contentView.tagsView.isUserInteractionEnabled = false
        } else {
            contentView.tagsView.isUserInteractionEnabled = true
            contentView.tagsView.isHidden = false
            contentView.tableView.isHidden = true
            contentView.buttonTag.isHidden = true
            contentView.searchEmptyView.isHidden = true
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text != nil else { return }
        contentView.tagsView.isUserInteractionEnabled = false
        contentView.tagsView.isHidden = true
        contentView.tableView.isHidden = false
        contentView.buttonTag.isHidden = true

        if let search = searchBar.text, search.count != 0 {
            interactor?.searchRecipes(search: search)
        } else {
            contentView.searchEmptyView.isHidden = true
        }
    }
}
