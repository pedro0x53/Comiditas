//
//  SearchModels.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 28/10/21.
//

import Foundation

enum Search {
    struct Response {
        let recipes: [RecipeJson]
        let search: String
    }

    struct ViewModel {
        let recipes: [RecipeJson]
    }
}
