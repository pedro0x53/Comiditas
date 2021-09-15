//
//  RecipeRepository.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 15/09/21.
//

import Foundation

class RecipeJsonRepository {
    let jsonStack = JsonStack(forResource: "Recipes")
    var data: Data?

    init() {
        loadData()
    }

    private func loadData() {
        if let url = jsonStack.jsonURL {
            data = try? Data(contentsOf: url)
        }
    }

    public func readAll() -> [RecipesJson] {
        guard let data = data else { return [] }
        do {
            let recipes = try jsonStack.decoder.decode([RecipesJson].self, from: data)
            return recipes
        } catch {
            return []
        }
    }
}
