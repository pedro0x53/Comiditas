//
//  OverviewCoordinatorUnitTests.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 29/09/21.
//
import XCTest
@testable import Comiditas

class OverviewCoordinatorUnitTests: XCTestCase {

    var sut: OverviewCoordinator!

    override func setUp() {
        sut = OverviewCoordinator(navigationController: UINavigationController())
    }

    override func tearDown() {
        sut = nil
    }

    func test_coordinator_start() {
        sut.recipe = RecipeJson(identifier: 0, name: "Test", imageURL: "",
                                difficultyLevel: 1, servings: 1, prepTime: 120, ingredients: [],
                                categories: [], rate: 5, steps: [])

        sut.start()

        XCTAssertNotNil(sut.navigationController.topViewController as? OverviewViewController)
    }

    func test_coordinator_coordinateToSteps() {
        let recipe = RecipeJson(identifier: 0, name: "Test", imageURL: "",
                                difficultyLevel: 1, servings: 1, prepTime: 120, ingredients: [],
                                categories: [], rate: 5, steps: [])

        sut.recipe = recipe
        sut.start()

        sut.coordinateToSteps(recipe: recipe)

        let expectation = XCTestExpectation(description: "Waiting for the animation")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)

        XCTAssertNotNil(sut.navigationController.topViewController as? PreparationViewController)
    }
}
