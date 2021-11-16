//
//  OverviewViewControllerTests.swift
//  ComiditasTests
//
//  Created by Pedro Sousa on 15/10/21.
//

import XCTest
@testable import Comiditas

// MARK: SetUp and TearDown
class OverviewViewControllerTests: XCTestCase {
    var sut: OverviewViewController!
    var spy: OverviewViewControllerSpy!

    override func setUp() {
        super.setUp()
        // MARK: Mocked data
        let step0 = StepJson(step: 0, stepDescription: "", hasTimer: false, timer: 0)
        let step1 = StepJson(step: 1, stepDescription: "", hasTimer: false, timer: 0)

        let recipe = RecipeJson(identifier: 0, name: "", imageURL: "",
                                difficultyLevel: 0, servings: 0, prepTime: 0,
                                ingredients: Array(repeating: "", count: 3), categories: [],
                                rate: 0, steps: [step0, step1])

        sut = OverviewViewController(recipe: recipe)

        let navController = UINavigationController(rootViewController: sut)
        sut.coordinator = OverviewCoordinator(navigationController: navController)

        spy = OverviewViewControllerSpy()
        sut.interactor = spy
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        spy = nil
    }
}

// MARK: View->Interactor tests
extension OverviewViewControllerTests {
    func test_overviewViewController_copySectionContent_ingredientsCopyRequested() {
        sut.copySectionContent(type: .ingredients)
        XCTAssertTrue(spy.didRequestCopyIngredients)
    }

    func test_overviewViewController_copySectionContent_directionsCopyRequested() {
        sut.copySectionContent(type: .direcions)
        XCTAssertTrue(spy.didRequestCopyDirections)
    }
}

// MARK: Presenter->View
extension OverviewViewControllerTests {
    func test_overviewViewController_sharedRecipe() {
        let viewModel = Overview.ViewModel.Sharing(content: "")
        sut.display(sharedRecipe: viewModel, animated: false) {
            XCTAssertNotNil(self.sut.coordinator?.navigationController
                                .presentingViewController as? UIActivityViewController)
        }
    }

    func test_overviewViewController_copiedRecipe() {
        let expected = "Mocked content"
        sut.display(copiedRecipe: Overview.ViewModel.Sharing(content: expected))

        let result = UIPasteboard.general.string
        XCTAssertNotNil(result)
        XCTAssertEqual(expected, result)
    }
}

// MARK: View->Coordinator tests
extension OverviewViewControllerTests {
    func test_overviewViewController_startRecipe_notNil() {
        sut.startRecipe()

        let expectation = XCTestExpectation(description: "Waiting for animated transition")
        _ = XCTWaiter.wait(for: [expectation], timeout: 1)

        XCTAssertNotNil(sut.coordinator?.navigationController.topViewController as? StepsViewController)
    }
}

// MARK: ViewController->OverviewView (OverviewView delegate, TableView delegate and dataSource) tests
extension OverviewViewControllerTests {
    func test_overviewViewController_numberOfSections_3() {
        let expected = 3
        let result = sut.numberOfSections(in: UITableView())
        XCTAssertEqual(expected, result)
    }

    func test_overviewViewController_numberOfRowsInFirstSection_1() {
        let expected = 1
        let result = sut.tableView(UITableView(), numberOfRowsInSection: 0)
        XCTAssertEqual(expected, result)
    }

    func test_overviewViewController_numberOfRowsInSecondSection_3() {
        let expected = 3
        let result = sut.tableView(UITableView(), numberOfRowsInSection: 1)
        XCTAssertEqual(expected, result)
    }

    func test_overviewViewController_numberOfRowsInThirdSection_2() {
        let expected = 2
        let result = sut.tableView(UITableView(), numberOfRowsInSection: 2)
        XCTAssertEqual(expected, result)
    }

    func test_overviewViewController_numberOfRowsInNonExistentSection_0() {
        let expected = 0
        let result = sut.tableView(UITableView(), numberOfRowsInSection: 4)
        XCTAssertEqual(expected, result)
    }

    func test_overviewViewController_cellForRow_headerCell() {
        let result = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(result as? RecipeHeaderCell)
    }

    func test_overviewViewController_cellForRow_ingredientCell() {
        let result = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 1))
        XCTAssertNotNil(result as? IngredientCell)
    }

    func test_overviewViewController_cellForRow_stepCell() {
        let result = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 2))
        XCTAssertNotNil(result as? RecipeStepCell)
    }

    func test_overviewViewController_cellForRow_defaultCell() {
        let result = sut.tableView(UITableView(), cellForRowAt: IndexPath(row: 0, section: 4))
        XCTAssertTrue(type(of: result) == UITableViewCell.self)
    }

    func test_overviewViewController_viewForHeaderInHeaderSection_nil() {
        let result = sut.tableView(UITableView(), viewForHeaderInSection: 0)
        XCTAssertNil(result)
    }

    func test_overviewViewController_viewForHeaderInIngredientAndDirectionsSection_headerView() {
        let result1 = sut.tableView(UITableView(), viewForHeaderInSection: 1)
        let result2 = sut.tableView(UITableView(), viewForHeaderInSection: 2)
        XCTAssertNotNil(result1 as? SectionHeaderView)
        XCTAssertNotNil(result2 as? SectionHeaderView)
    }

    func test_overviewViewController_viewForHeaderInNonExistentSection_nil() {
        let result = sut.tableView(UITableView(), viewForHeaderInSection: 4)
        XCTAssertNil(result)
    }

    func test_overviewViewController_heightForHeaderInHeaderSection_0() {
        let expected: CGFloat = 0
        let result = sut.tableView(UITableView(), heightForHeaderInSection: 0)
        XCTAssertEqual(expected, result)
    }

    func test_overviewViewController_heightForHeaderInIngredientsAndDirectionsSection_44() {
        let expected: CGFloat = 44
        let result1 = sut.tableView(UITableView(), heightForHeaderInSection: 1)
        let result2 = sut.tableView(UITableView(), heightForHeaderInSection: 2)
        XCTAssertEqual(expected, result1)
        XCTAssertEqual(expected, result2)
    }

    func test_overviewViewController_heightForHeaderInHNonExistentSection_0() {
        let expected: CGFloat = 0
        let result = sut.tableView(UITableView(), heightForHeaderInSection: 4)
        XCTAssertEqual(expected, result)
    }
}
