//
//  PreparationWorker.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation

class PreparationWorker {

    private let repository: RecipeJsonRepository = RecipeJsonRepository()

    func readSteps(from recipeIdentifier: Int) -> [StepJson] {
        let recipes = repository.readAll()
        let selectedRecipe = recipes.first(where: { recipe in
            recipe.identifier == recipeIdentifier
        })

        return selectedRecipe?.steps ?? []
    }

}
