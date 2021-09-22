//
//  OverviewViewController.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//

import UIKit

class OverviewViewController: UIViewController {

    var coordinator: OverviewCoordinator?
    let associatedView: OverviewView = OverviewView()

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
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension OverviewViewController: OverviewViewDelegate {
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
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecipeHeaderCell.identifier) as? RecipeHeaderCell
            else {
                return UITableViewCell()
            }
            let time = Time.secondsToHoursMinutesSeconds(seconds: recipe.prepTime)
            cell.configure(imageURL: recipe.imageURL, title: recipe.name,
                           servings: "\(recipe.servings) porções", prepTime: "\(time.minutes) minutos",
                           difficulty: Difficulty(rawValue: recipe.difficultyLevel)?.description ?? "Fácil",
                           rating: recipe.rate)

            return cell

        case .ingredients:
            let ingredient = "\(recipe.ingredients[indexPath.row])"

            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: IngredientCell.identifier) as? IngredientCell
            else {
                return UITableViewCell()
            }

            cell.configure(text: ingredient)

            return cell

        case .steps:
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RecipeStepCell.identifier) as? RecipeStepCell
            else {
                return UITableViewCell()
            }

            cell.configure(title: "Passo \(indexPath.row + 1)",
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
            let title: String = (section == .ingredients) ? "Ingredientes" : "Modo de Preparo"
            guard let header = tableView.dequeueReusableHeaderFooterView(
                    withIdentifier: SectionHeaderView.identifier) as? SectionHeaderView
            else {
                let header = SectionHeaderView()
                header.configure(title: title)
                return header
            }

            header.configure(title: title)
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

extension OverviewViewController {
    enum OverviewSection: Int {
        case header = 0
        case ingredients = 1
        case steps = 2
    }
}

extension OverviewViewController {
    func startRecipe() {
        coordinator?.coordinateToSteps(recipe: self.recipe)
    }
}
