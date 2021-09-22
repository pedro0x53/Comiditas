//
//  PreparationWorker.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation

class PreparationWorker {

    func readSteps(from recipe: RecipeJson) -> [StepJson] {
        return recipe.steps
    }

}
