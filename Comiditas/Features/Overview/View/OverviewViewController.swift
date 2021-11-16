//
//  OverviewViewController.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//

import UIKit

class OverviewViewController: UIViewController {
    let associatedView: OverviewView = OverviewView()

    var coordinator: OverviewCoordinator?
    var interactor: OverviewInteractorProtocol?

    var recipe: RecipeJson

    init(recipe: RecipeJson) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        associatedView.delegate = self
        self.view = associatedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        setupNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    private func setupVIP() {
        let interactor = OverviewInteractor()
        let presenter = OverviewPresenter()
        interactor.presenter = presenter
        presenter.view = self
        self.interactor = interactor
    }

    private func setupNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = OverviewLocalizable.title.text

        if let shareImage = UIImage(systemName: "square.and.arrow.up") {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: shareImage,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(shareAction))
        }
    }

    @objc func shareAction() {
        interactor?.request(recipe: Overview.Request(recipe: self.recipe))
    }
}

extension OverviewViewController: OverviewViewDelegate {
    enum OverviewSection: Int {
        case header = 0
        case ingredients = 1
        case steps = 2
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = OverviewSection(rawValue: section) else { return 0 }
        switch section {
        case .header:
            return 1
        case .ingredients:
            return recipe.ingredients.count
        case .steps:
            return recipe.steps.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = OverviewSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .header:
            let time = Time.secondsToHoursMinutesSeconds(seconds: recipe.prepTime)
            let difficulty = Difficulty(rawValue: recipe.difficultyLevel) ?? .medium

            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecipeHeaderCell.identifier) as? RecipeHeaderCell
            else {
                let cell = RecipeHeaderCell()
                cell.configure(imageURL: recipe.imageURL, title: recipe.name, servings: "\(recipe.servings)",
                               prepTime: time, difficulty: difficulty, rating: recipe.rate)
                return cell
            }

            cell.configure(imageURL: recipe.imageURL, title: recipe.name, servings: "\(recipe.servings)",
                           prepTime: time, difficulty: difficulty, rating: recipe.rate)
            return cell

        case .ingredients:
            let ingredient = "\(recipe.ingredients[indexPath.row])"

            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: IngredientCell.identifier) as? IngredientCell
            else {
                let cell = IngredientCell()
                cell.configure(text: ingredient)
                return cell
            }

            cell.configure(text: ingredient)
            return cell

        case .steps:
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecipeStepCell.identifier) as? RecipeStepCell
            else {
                let cell = RecipeStepCell()
                cell.configure(index: "\(indexPath.row + 1)",
                               description: recipe.steps[indexPath.row].stepDescription)
                return cell
            }

            cell.configure(index: "\(indexPath.row + 1)",
                           description: recipe.steps[indexPath.row].stepDescription)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = OverviewSection(rawValue: section) else { return nil }
        switch section {
        case .header:
            return nil
        case .ingredients, .steps:
            let title: String = (section == .ingredients) ?
                                OverviewLocalizable.ingredients.text : OverviewLocalizable.directions.text
            let type: OverviewCopyType = (section == .ingredients) ? .ingredients : .direcions

            guard let header = tableView.dequeueReusableHeaderFooterView(
                    withIdentifier: SectionHeaderView.identifier) as? SectionHeaderView
            else {
                let header = SectionHeaderView()
                header.configure(title: title, type: type)
                header.delegate = self
                return header
            }

            header.configure(title: title, type: type)
            header.delegate = self
            return header
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = OverviewSection(rawValue: section) else { return 0 }
        switch section {
        case .header:
            return 0
        case .ingredients, .steps:
            return 44
        }
    }
}

// Delegate Connection: ViewController->View
extension OverviewViewController {
    func startRecipe() {
        let headerIndexPath = IndexPath(row: 0, section: OverviewSection.header.rawValue)
        let headerCell = associatedView.tableView.cellForRow(at: headerIndexPath) as? RecipeHeaderCell
        coordinator?.coordinateToSteps(recipe: self.recipe, image: headerCell?.headerImage)
    }
}

// VIP Connection: Presenter->View
extension OverviewViewController: OverviewPresenterDelegate {
    func display(sharedRecipe: Overview.ViewModel.Sharing,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        self.coordinator?.shareText(content: sharedRecipe.content, animated: animated, completion: completion)
    }

    func display(copiedRecipe: Overview.ViewModel.Sharing) {
        UIPasteboard.general.string = copiedRecipe.content
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}

// Delegate Connection: ViewController->TableView Header
extension OverviewViewController: SectionHeaderViewDelegate {
    func copySectionContent(type: OverviewCopyType) {
        let request = Overview.Request(recipe: self.recipe)
        interactor?.request(recipe: request, type: type)
    }
}
