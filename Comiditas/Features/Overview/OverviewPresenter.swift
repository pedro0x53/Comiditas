//
//  OverviewPresenter.swift
//  Comiditas
//
//  Created by Pedro Sousa on 06/10/21.
//

import Foundation
import UIKit

protocol OverviewPresenterProtocol {
    func present(response: Overview.Response.Share)
    func present(response: Overview.Response.Copy)
}

protocol OverviewPresenterDelegate: AnyObject {
    func display(sharedRecipe: Overview.ViewModel.Sharing, animated: Bool, completion: (() -> Void)?)
    func display(copiedRecipe: Overview.ViewModel.Sharing)
}

class OverviewPresenter: OverviewPresenterProtocol {
    weak var view: OverviewPresenterDelegate?

    func present(response: Overview.Response.Share) {
        var content: String = OverviewLocalizable.sharingTitle.text + "\n\n"

        content += response.name + "\n"
        content += OverviewLocalizable.servings.text + response.servings + "\n\n"

        content += OverviewLocalizable.ingredients.text + "\n\n"
        for ingredient in response.ingredients {
            content += ingredient + "\n"
        }

        content += "\n" + OverviewLocalizable.directions.text + "\n\n"
        for (index, step) in response.steps.enumerated() {
            content += "\(index + 1). \(step) \n"
        }

        let viewModel = Overview.ViewModel.Sharing(content: content)
        view?.display(sharedRecipe: viewModel, animated: true, completion: nil)
    }

    func present(response: Overview.Response.Copy) {
        var content: String = ""
        switch response.type {
        case .ingredients:
            content += OverviewLocalizable.ingredients.text + "\n\n"
            content += response.content.joined(separator: "\n")
        case .direcions:
            content = OverviewLocalizable.directions.text + "\n\n"
            for (index, step) in response.content.enumerated() {
                content += "\(index + 1). \(step) \n"
            }
        }

        view?.display(copiedRecipe: Overview.ViewModel.Sharing(content: content))
    }
}
