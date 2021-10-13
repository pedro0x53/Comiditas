//
//  OverviewPresenter.swift
//  Comiditas
//
//  Created by Pedro Sousa on 06/10/21.
//

import Foundation

protocol OverviewPresenterProtocol {
    func present(response: Overview.Response.Share)
}

protocol OverviewPresenterDelegate: AnyObject {
    func display(sharedRecipe: Overview.ViewModel.Sharing)
}

class OverviewPresenter: OverviewPresenterProtocol {
    weak var view: OverviewPresenterDelegate?

    func present(response: Overview.Response.Share) {
        var content: String = OverviewLocalizable.sharingTitle.text + "\n\n"

        content += response.name + "\n"
        content += OverviewLocalizable.servings.text + response.servings + "\n\n"

        content += OverviewLocalizable.ingredients.text + "\n\n"
        content += response.ingredients.reduce("", { partialResult, ingredient in
            return partialResult + ingredient + "\n"
        })

        content += "\n" + OverviewLocalizable.directions.text + "\n\n"
        for (index, step) in response.steps.enumerated() {
            content += "\(index + 1). \(step) \n"
        }

        let viewModel = Overview.ViewModel.Sharing(content: content)
        view?.display(sharedRecipe: viewModel)
    }
}
