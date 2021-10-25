//
//  StepsWorker.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import Foundation

class StepsWorker {
    func readSteps(from recipe: RecipeJson) -> [StepJson] {
        return recipe.steps
    }
}
