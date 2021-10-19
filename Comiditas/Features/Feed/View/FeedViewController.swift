//
//  FeedViewController.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

protocol FeedViewControllerProtocol: AnyObject {
    func displayRecipes(viewModel: Feed.ViewModel)
    func displayRecommendations(viewModel: Feed.ViewModel)
}

class FeedViewController: UIViewController {
    var coordinator: FeedCoordinatorProtocol?
    let contentView = FeedView(frame: UIScreen.main.bounds)
    let tag: [String] = [FeedLocalizable.candy.text, FeedLocalizable.salted.text]
    var interactor: FeedInteractorProtocol?
    var recipes: [RecipeJson] = [] {
        didSet {
            self.contentView.tableView.reloadData()
        }
    }

    var recommendations: [RecipeJson] = [] {
        didSet {
            self.contentView.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        interactor?.getRecipes()
        interactor?.getRecommendations()
        setupViewController()
        contentView.searchBar.delegate = self
    }

    override func loadView() {
        self.view = contentView
    }

    func setupViewController() {
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        title = FeedLocalizable.title.text
    }

    func setupVIP() {
        let viewController = self
        let interactor = FeedInteractor()
        let presenter = FeedPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension FeedViewController: FeedViewControllerProtocol {
    func displayRecommendations(viewModel: Feed.ViewModel) {
        self.recommendations = viewModel.recipes
        self.contentView.tableView.reloadData()
    }

    func displayRecipes(viewModel: Feed.ViewModel) {
        self.recipes = viewModel.recipes
        self.contentView.tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionsName = [FeedLocalizable.recommendedForYou.text, FeedLocalizable.otherRecipes.text]
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
        let headerView = UIView(frame: rect)
        headerView.backgroundColor = Colors.background

        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.size.width, height: 44))
        label.text = sectionsName[section]
        label.isAccessibilityElement = true
        label.accessibilityLabel = sectionsName[section]
        label.accessibilityTraits = .header
        label.textColor = Colors.textDark
        label.font = Fonts.h3
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as? FeedTableViewCell
            else { return UITableViewCell() }
            cell.delegate = self
            cell.reloadData()
            cell.data = (indexPath.section == .zero) ? recommendations : recipes
            return cell
        }
        return UITableViewCell()
    }
}

extension FeedViewController: UISearchBarDelegate {}

extension FeedViewController: FeedTableViewCellProtocol {
    func didSelectItemAt(recipe: RecipeJson) {
        coordinator?.navigateToOverview(recipe: recipe)
    }
}
