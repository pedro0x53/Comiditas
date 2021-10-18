//
//  OverviewPresenterSpy.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 15/10/21.
//

import Foundation
@testable import Comiditas
import UIKit

class OverviewPresenterSpy: OverviewPresenterDelegate {
    var didFormatedContentCorrectly: Bool = false

    func display(sharedRecipe: Overview.ViewModel.Sharing, animated: Bool, completion: (() -> Void)?) {
        var mockedContent: String = OverviewLocalizable.sharingTitle.text + "\n\n"

        mockedContent += "Mock\n"
        mockedContent += OverviewLocalizable.servings.text + "3\n\n"

        mockedContent += OverviewLocalizable.ingredients.text + "\n\n"
        let ingredients = ["Ingredient 1", "Ingredient 2", "Ingredient 3"]
        for ingredient in ingredients {
            mockedContent += ingredient + "\n"
        }

        mockedContent += "\n" + OverviewLocalizable.directions.text + "\n\n"
        let steps = ["Step 1", "Step 2", "Step 3", "Step 4"]
        for (index, step) in steps.enumerated() {
            mockedContent += "\(index + 1). \(step) \n"
        }

        didFormatedContentCorrectly = sharedRecipe.content == mockedContent
    }

    func display(copiedRecipe: Overview.ViewModel.Sharing) {
        UIPasteboard.general.string = copiedRecipe.content
    }
}
