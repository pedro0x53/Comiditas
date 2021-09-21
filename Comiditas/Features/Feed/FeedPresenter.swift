//
//  FeedPresenter.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 21/09/21.
//

import Foundation

protocol FeedPresenterProtocol {
    func presentRecipes(response: Feed.Feed.Response)
}

class FeedPresenter: FeedPresenterProtocol {
    weak var viewController: FeedViewControllerProtocol?

    func presentRecipes(response: Feed.Feed.Response) {
        let viewModel = Feed.Feed.ViewModel(recipes: response.recipes)
        viewController?.displayRecipes(viewModel: viewModel)
    }
}
