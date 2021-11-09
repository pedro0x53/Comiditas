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
    private let worker = SearchWorker.shared

    func searchRecipes(search: String) {
        let data = worker.searchRecipes()
        let response = Search.Response(recipes: data, search: search)
        presenter?.presentSearchRecipes(response: response)
    }

    func searchTagRecipes(search: String) {
        let data = worker.searchRecipes()
        let response = Search.Response(recipes: data, search: search)
        presenter?.presentSearchTagsRecipes(response: response)
    }
}
