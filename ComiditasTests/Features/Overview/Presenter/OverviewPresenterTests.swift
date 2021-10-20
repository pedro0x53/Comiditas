//
//  OverviewPresenterTests.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 15/10/21.
//

import XCTest
@testable import Comiditas

// MARK: SetUp and TearDown
class OverviewPresenterTests: XCTestCase {
    var sut: OverviewPresenter!
    var spy: OverviewPresenterSpy!
    var mockedRecipe: RecipeJson!

    override func setUp() {
        super.setUp()
        // MARK: Mocked data
        let step0 = StepJson(step: 0, stepDescription: "", hasTimer: false, timer: 0)
        let step1 = StepJson(step: 1, stepDescription: "", hasTimer: false, timer: 0)

        mockedRecipe = RecipeJson(identifier: 0, name: "", imageURL: "",
                                  difficultyLevel: 0, servings: 0, prepTime: 0,
                                  ingredients: Array(repeating: "", count: 3), categories: [],
                                  rate: 0, steps: [step0, step1])

        sut = OverviewPresenter()

        spy = OverviewPresenterSpy()
        sut.view = spy
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        spy = nil
    }
}

// MARK: Presenter->View tests
extension OverviewPresenterTests {
    func test_overviewPresenter_presentShare() {
        let response = Overview.Response.Share(name: "Mock", servings: "3",
                                               ingredients: ["Ingredient 1", "Ingredient 2", "Ingredient 3"],
                                               steps: ["Step 1", "Step 2", "Step 3", "Step 4"])
        sut.present(response: response)
        XCTAssertTrue(spy.didFormatedContentCorrectly)
    }

    func test_overviewPresenter_presentIngredientCopy() {
        let ingredients = ["Ingredient 1", "Ingredient 2", "Ingredient 3"]
        let response = Overview.Response.Copy(type: .ingredients,
                                              content: ingredients)
        sut.present(response: response)

        let expected = OverviewLocalizable.ingredients.text + "\n\n" + ingredients.joined(separator: "\n")
        let result = UIPasteboard.general.string

        XCTAssertEqual(expected, result)
    }

    func test_overviewPresenter_presentDirectionsCopy() {
        let steps = ["Step 1", "Step 2", "Step 3", "Step 4"]
        let response = Overview.Response.Copy(type: .direcions,
                                              content: steps)
        sut.present(response: response)

        var expected = OverviewLocalizable.directions.text + "\n\n"
        for (index, step) in response.content.enumerated() {
            expected += "\(index + 1). \(step) \n"
        }
        let result = UIPasteboard.general.string

        XCTAssertEqual(expected, result)
    }
}
