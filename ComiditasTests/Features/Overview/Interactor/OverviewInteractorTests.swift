//
//  OverviewInteractorTests.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 15/10/21.
//

import XCTest
@testable import Comiditas

// MARK: SetUp and TearDown
class OverviewInteractorTests: XCTestCase {
    var sut: OverviewInteractor!
    var spy: OverviewInteractorSpy!
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

        sut = OverviewInteractor()

        spy = OverviewInteractorSpy()
        sut.presenter = spy
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        spy = nil
    }
}

// MARK: Interactor->Presenter tests
extension OverviewInteractorTests {
    func test_overviewInteractor_sharedRecipe() {
        sut.request(recipe: Overview.Request(recipe: mockedRecipe))
        XCTAssertTrue(spy.didAskToPresentSharedContent)
    }

    func test_overviewInteractor_recipeToCopy_directions() {
        sut.request(recipe: Overview.Request(recipe: mockedRecipe), type: .direcions)
        XCTAssertTrue(spy.didAskToPresentCopiedContent)
    }

    func test_overviewInteractor_recipeToCopy_ingredients() {
        sut.request(recipe: Overview.Request(recipe: mockedRecipe), type: .ingredients)
        XCTAssertTrue(spy.didAskToPresentCopiedContent)
    }
}
