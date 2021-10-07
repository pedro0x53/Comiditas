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
    }

    override func loadView() {
        self.view = contentView
    }

    func setupViewController() {
        contentView.tagCollectionView.delegate = self
        contentView.tagCollectionView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        title = "Comiditas"
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

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tag.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as? TagCollectionViewCell
        else { return UICollectionViewCell() }

        cell.titleLabel.text = tag[indexPath.row]
        return cell
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
        if section != .zero && FeatureFlags.tagsFeed.isEnable {
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
            let headerView = UIView(frame: rect)
            headerView.backgroundColor = Colors.background
            let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.size.width, height: 44))
            label.text = FeedLocalizable.recommendedForYou.text
            label.textColor = Colors.primary
            label.isAccessibilityElement = true
            label.accessibilityLabel = FeedLocalizable.recommendedForYou.text
            label.accessibilityTraits = .header
            label.accessibilityValue = FeedLocalizable.recommendedForYou.text
            label.font = Fonts.h3
            headerView.addSubview(label)
            return headerView
        } else {
            let sectionsName = [FeedLocalizable.recommendedForYou.text, FeedLocalizable.otherRecipes.text]
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
            let headerView = UIView(frame: rect)
            headerView.backgroundColor = Colors.background
            let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.size.width, height: 44))
            label.text = sectionsName[section]
            label.isAccessibilityElement = true
            label.accessibilityLabel = sectionsName[section]
            label.accessibilityTraits = .header
            label.textColor = Colors.primary
            label.font = Fonts.h3
            headerView.addSubview(label)
            return headerView
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if FeatureFlags.tagsFeed.isEnable {
            return .zero
        } else {
            return 44
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as? FeedTableViewCell
            else { return UITableViewCell() }
        cell.delegate = self
        cell.reloadData()
        cell.data = (indexPath.section == .zero) ? recommendations : recipes
        return cell
    }
}

extension FeedViewController: FeedTableViewCellProtocol {
    func didSelectItemAt(recipe: RecipeJson) {
        coordinator?.navigateToOverview(recipe: recipe)
    }
}
