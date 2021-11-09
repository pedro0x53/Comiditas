//
//  SearchPresenter.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 28/10/21.
//

import Foundation

protocol SearchPresenterProtocol {
    func presentSearchRecipes(response: Search.Response)
    func presentSearchTagsRecipes(response: Search.Response)
}

class SearchPresenter: SearchPresenterProtocol {
    var viewController: SearchViewControllerProtocol?

    func presentSearchRecipes(response: Search.Response) {
        let recipes = response.recipes
        let search = response.search

        let filter = recipes.filter({ $0.name.range(of: search, options: .caseInsensitive) != nil })
        let viewModel = Search.ViewModel(recipes: filter)
        viewController?.displayRecipes(viewModel: viewModel)
    }

    func presentSearchTagsRecipes(response: Search.Response) {
        let recipes = response.recipes
        let search = response.search

//        let filter = recipes.filter({ $0.categories[0].range(of: search, options: .caseInsensitive) != nil })
        let filter =  recipes.compactMap {
            $0.categories.contains(search) ? $0 : nil
        }
        let viewModel = Search.ViewModel(recipes: filter)
        viewController?.displayRecipes(viewModel: viewModel)
    }
}
