//
//  OverviewPresentar.swift
//  Comiditas
//
//  Created by Pedro Sousa on 06/10/21.
//

import Foundation

protocol OverviewPresenterProtocol {
    func present(response: Overview.Response.Share)
}

protocol OverviewPresenterDelegate: AnyObject {
    func display(sharedRecipe content: Overview.ViewModel)
}

class OverviewPresenter: OverviewPresenterProtocol {
    func present(response: Overview.Response.Share) {}
}
