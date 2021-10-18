//
//  OverviewViewControllerSpy.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 15/10/21.
//

import Foundation
@testable import Comiditas

class OverviewViewControllerSpy: OverviewInteractorProtocol {

    var didRequestSharing: Bool = false
    var didRequestCopyIngredients: Bool = false
    var didRequestCopyDirections: Bool = false

    func request(recipe sharedRecipe: Overview.Request) {
        self.didRequestSharing = true
    }

    func request(recipe recipeToCopy: Overview.Request, type: OverviewCopyType) {
        switch type {
        case .ingredients:
            self.didRequestCopyIngredients = true
        case .direcions:
            self.didRequestCopyDirections = true
        }
    }
}
