//
//  Recipes.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 15/09/21.
//

import UIKit

struct RecipesJson: Decodable {
    let identifier: Int
    let name: String
    let imageURL: String
    let difficultyLevel: Int
    let servings: Int
    let prepTime: Int
    let ingredients: [IngredientsJson]
    let categories: [String]
    let rate: Int
    let steps: [StepJson]
}
