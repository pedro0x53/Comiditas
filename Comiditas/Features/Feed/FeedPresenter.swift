//
//  FeedPresenter.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 21/09/21.
//

import Foundation

protocol FeedPresenterProtocol {
    func presentRecipes(response: Feed.Response)
    func presentRecommendations(response: Recommendations.Response)
}

class FeedPresenter: FeedPresenterProtocol {
    weak var viewController: FeedViewControllerProtocol?

    func presentRecipes(response: Feed.Response) {
        let viewModel = Feed.ViewModel(recipes: response.recipes)
        viewController?.displayRecipes(viewModel: viewModel)
    }

    func presentRecommendations(response: Recommendations.Response) {
        let viewModel = Recommendations.ViewModel(recipes: response.recipes)
        viewController?.displayRecommendations(viewModel: viewModel)
    }
}
