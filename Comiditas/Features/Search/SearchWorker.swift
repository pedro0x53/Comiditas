//
//  SearchWorker.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 09/11/21.
//

import Foundation

class SearchWorker {
    public static let shared = SearchWorker()

    func searchRecipes() -> [RecipeJson] {
        var response: [RecipeJson] = []

        let jsonRecipes = RecipeJsonRepository(named: "Recipes")
        if let data = jsonRecipes.readAll([RecipeJson].self) {
            response.append(contentsOf: data)
        }

        let json = RecipeJsonRepository(named: "DailySpecials")
        if let data = json.readAll([DailySpecial].self) {
            let recipes = data.reduce([]) { partialResult, currentValue in
                return partialResult + currentValue.recipes
            }
            response.append(contentsOf: recipes)
        }

        return response
    }
}
