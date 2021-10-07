//
//  FeedInteractor.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 21/09/21.
//

import Foundation

protocol FeedInteractorProtocol {
    func getRecipes()
    func getRecommendations()
}

class FeedInteractor: FeedInteractorProtocol {
    var presenter: FeedPresenterProtocol?

    func getRecipes() {
        let json = RecipeJsonRepository(named: "Recipes")
        let data = json.readAll()
        let response = Feed.Response(recipes: data)
        presenter?.presentRecipes(response: response)
    }

    func getRecommendations() {
        let json = RecipeJsonRepository(named: "Recommendations")
        let data = json.readAll()
        let response = Feed.Response(recipes: data)
        presenter?.presentRecommendations(response: response)
    }
}
