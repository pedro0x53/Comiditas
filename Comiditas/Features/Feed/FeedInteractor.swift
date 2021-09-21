//
//  FeedInteractor.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 21/09/21.
//

import Foundation

protocol FeedInteractorProtocol {
    func getRecipes()
}

class FeedInteractor: FeedInteractorProtocol {
    var presenter: FeedPresenterProtocol?

    func getRecipes() {
        let json = RecipeJsonRepository()
        let data = json.readAll()
        let response = Feed.Response(recipes: data)
        presenter?.presentRecipes(response: response)
    }
}
