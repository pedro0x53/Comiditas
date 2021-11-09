//
//  SearchInteractor.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 28/10/21.
//

import UIKit

protocol SearchInteractorProtocol {
    func searchRecipes(search: String)
    func searchTagRecipes(search: String)
}

class SearchInteractor: SearchInteractorProtocol {
    var presenter: SearchPresenterProtocol?

    func searchRecipes(search: String) {
        let json = RecipeJsonRepository(named: "Recipes")
        let data = json.readAll()
        let response = Search.Response(recipes: data, search: search)
        presenter?.presentSearchRecipes(response: response)
    }

    func searchTagRecipes(search: String) {
        let json = RecipeJsonRepository(named: "Recipes")
        let data = json.readAll()
        let response = Search.Response(recipes: data, search: search)
        presenter?.presentSearchTagsRecipes(response: response)
    }
}
