//
//  FeedViewController.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

protocol FeedViewControllerProtocol: AnyObject {
    func displayRecipes(viewModel: Feed.ViewModel)
    func displayRecommendations(viewModel: Recommendations.ViewModel)
}

class FeedViewController: UIViewController {
    var coordinator: FeedCoordinatorProtocol?
    let contentView = FeedView(frame: UIScreen.main.bounds)
    var sectionsName = [FeedLocalizable.recommendedForYou.text, FeedLocalizable.otherRecipes.text]
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
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        title = FeedLocalizable.title.text
        let image = UIImage(assetIdentifier: .settingsicon)!.withRenderingMode(.alwaysOriginal)
        let addButton: UIBarButtonItem = UIBarButtonItem(
            image: image,
            style: .done,
            target: self,
            action: #selector(addTapped)
        )
        addButton.isAccessibilityElement = true
        addButton.accessibilityTraits = .button
        addButton.accessibilityLabel = "Configurações"
        self.navigationItem.rightBarButtonItem = addButton

    }

    @objc func addTapped(sender: AnyObject) {
        coordinator?.navigateToSettings()
    }

    func setupVIP() {
        let viewController = self
        let interactor = FeedInteractor()
        let presenter = FeedPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController

        contentView.delegate = self
    }
}

extension FeedViewController: FeedViewControllerProtocol {
    func displayRecommendations(viewModel: Recommendations.ViewModel) {
        self.recommendations = viewModel.recipes.recipes
        self.sectionsName[0] = viewModel.recipes.title
        self.contentView.tableView.reloadData()
    }

    func displayRecipes(viewModel: Feed.ViewModel) {
        self.recipes = viewModel.recipes
        self.contentView.tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == .zero {
            return 1
        }

        return recipes.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "FeedTableViewCell",
                    for: indexPath) as? FeedTableViewCell
            else { return UITableViewCell() }
            cell.data = recommendations
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else {
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
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != .zero {
            coordinator?.navigateToOverview(recipe: recipes[indexPath.row])
        } else {
            coordinator?.navigateToOverview(recipe: recommendations[indexPath.row])
        }
    }
}

extension FeedViewController: FeedTableViewCellProtocol {
    func didSelectItemAt(recipe: RecipeJson) {
        coordinator?.navigateToOverview(recipe: recipe)
    }
}

extension FeedViewController: FeedViewProtocol {
    func tapSearchBar() {
        coordinator?.navigateToSearch()
    }
}
