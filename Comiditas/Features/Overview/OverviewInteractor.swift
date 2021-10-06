//
//  OverviewInteractor.swift
//  Comiditas
//
//  Created by Pedro Sousa on 06/10/21.
//

import Foundation

protocol OverviewInteractorProtocol: AnyObject {
    func request(recipe sharedRecipe: Overview.Request)
}

class OverviewInteractor: OverviewInteractorProtocol {
    var presenter: OverviewPresenterProtocol?

    func request(recipe sharedRecipe: Overview.Request) {
        let recipe = sharedRecipe.recipe
        let steps: [String] = recipe.steps.map { step in
            var description = step.stepDescription
            if step.hasTimer {
                let time = Time.secondsToHoursMinutesSeconds(seconds: step.timer)
                description += "(" + Time.getString(for: time).accessible + ")"
            }
            return description
        }

        let ingredients: [String] = recipe.ingredients.compactMap { $0.description }

        let sharedResponse = Overview.Response.Share(name: recipe.name, servings: "\(recipe.servings)",
                                                     ingredients: ingredients, steps: steps)

        presenter?.present(response: sharedResponse)
    }
}
