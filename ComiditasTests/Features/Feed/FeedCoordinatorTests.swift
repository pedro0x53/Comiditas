//
//  FeedCoordinatorTests.swift
//  ComiditasTests
//
//  Created by Beatriz Carlos on 30/09/21.
//

import XCTest
@testable import Comiditas

class FeedCoordinatorTests: XCTestCase {
    var sut: FeedCoordinator!
    var navController: UINavigationController!

    override func setUp() {
        navController = UINavigationController()
        sut = FeedCoordinator(navigationController: navController)
    }

    override func tearDown() {
        sut = nil
        navController = nil
    }

    func testCoordinatorStart() {
         sut.start()
         XCTAssertNotNil(sut.navigationController.topViewController as? FeedViewController)
     }

    func testNavigateToOverview() {
        let recipe = RecipeJson(identifier: 0, name: "Test", imageURL: "",
                                difficultyLevel: 1, servings: 1, prepTime: 120, ingredients: [],
                                categories: [], rate: 5, steps: [])

        sut.start()

        sut.navigateToOverview(recipe: recipe)

        let expectation = XCTestExpectation(description: "Waiting for the animation")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1.0)

        XCTAssertNotNil(sut.navigationController.topViewController as? OverviewViewController)
    }
}
