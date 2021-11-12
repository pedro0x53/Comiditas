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
        guard let data = json.readAll([RecipeJson].self) else { return }
        let response = Feed.Response(recipes: data)
        presenter?.presentRecipes(response: response)
    }

    func getRecommendations() {
        let json = RecipeJsonRepository(named: "DailySpecials")
        guard let data = json.readAll([DailySpecial].self) else { return }
        if let random = data.randomElement() {
            let response = Recommendations.Response(recipes: random)
            presenter?.presentRecommendations(response: response)
        }
    }
}
