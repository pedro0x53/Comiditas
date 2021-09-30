//
//  PreparationViewControllerTests.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 29/09/21.
//

import XCTest
@testable import Comiditas

class PreparationViewControllerTests: XCTestCase {

    var sut: PreparationViewController!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupPreparationViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupPreparationViewController() {
        sut = PreparationViewController(nibName: nil, bundle: nil)
        sut.recipe = setupBasicRecipeMOCK()
        let mockIndexPath = IndexPath(row: 0, section: 0)
        sut.preparationView.indexPathOnScreen = mockIndexPath
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles

    class PreparationBusinessLogicSpy: PreparationBusinessLogic {

        // MARK: Method call expectations

        var requestStepsCalled = false
        var requestNextStepCalled = false
        var requestPreviousStepCalled = false
        var requestFinishedCalled = false

        // MARK: Argument expectations

        var requestStepsRequest: PreparationModels.GetSteps.Request!
        var requestNextStepRequest: PreparationModels.NextStep.Request!
        var requestPreviousStepRequest: PreparationModels.PreviousStep.Request!
        var requestFinishedRequest: PreparationModels.Finished.Request!

        func requestSteps(request: PreparationModels.GetSteps.Request) {
            requestStepsCalled = true
            self.requestStepsRequest = request
        }

        func requestNextStep(request: PreparationModels.NextStep.Request) {
            requestNextStepCalled = true
            self.requestNextStepRequest = request
        }

        func requestPreviousStep(request: PreparationModels.PreviousStep.Request) {
            requestPreviousStepCalled = true
            self.requestPreviousStepRequest = request
        }

        func requestFinished(request: PreparationModels.Finished.Request) {
            requestFinishedCalled = true
            self.requestFinishedRequest = request

        }
    }

    class PreparationViewDelegateSpy: PreparationViewDelegate {

        var didPressNextButtonCalled: Bool = false
        var didPressPreviousButtonCalled: Bool = false
        var didFinishCalled: Bool = false

        var nextButtonIndexPath: IndexPath!
        var previousButtonIndexPath: IndexPath!

        func didPressNextButton(indexPath: IndexPath) {
            didPressNextButtonCalled = true
            nextButtonIndexPath = indexPath
        }

        func didPressPreviousButton(indexPath: IndexPath) {
            didPressPreviousButtonCalled = true
            previousButtonIndexPath = indexPath
        }

        func didFinish() {
            didFinishCalled = true
        }
    }

    // MARK: Tests

    func testShouldFetchStepsWhenViewWillAppear() {
        // Given
        let preparationBusinessLogicSpy = PreparationBusinessLogicSpy()
        sut.interactor = preparationBusinessLogicSpy

        // When
        loadView()

        // Then
        XCTAssert(preparationBusinessLogicSpy.requestStepsCalled,
                  "Should fetch recipes right after the view appears")
    }

    func testShouldGoToNextInstructionWhenNextButtonPressed() {
        // Given
        let preparationBusinessLogicSpy = PreparationBusinessLogicSpy()
        sut.interactor = preparationBusinessLogicSpy

        // When
        loadView()
        sut.preparationView.nextButtonAction(UIButton())

        // Then
        XCTAssert(preparationBusinessLogicSpy.requestNextStepCalled,
                  "Should request next step after next step button is pressed.")
        XCTAssertEqual(preparationBusinessLogicSpy.requestNextStepRequest.currentIndexPath,
                       sut.preparationView.indexPathOnScreen)
    }

    func testShouldCallDidPressNextButtonWhenNextButtonPressed() {
        // Given
        let preparationViewDelegateSpy = PreparationViewDelegateSpy()
        sut.preparationView.delegate = preparationViewDelegateSpy

        // When
        loadView()
        sut.preparationView.nextButtonAction(UIButton())

        // Then
        XCTAssert(preparationViewDelegateSpy.didPressNextButtonCalled,
                  "Should call didPressNextButton function after next step button is pressed.")
        XCTAssertEqual(preparationViewDelegateSpy.nextButtonIndexPath,
                       sut.preparationView.indexPathOnScreen)
    }

    // MARK: Variables

    lazy var simplePreparation = setupBasicRecipeMOCK()

    // MARK: - MOCKS

    func setupBasicRecipeMOCK() -> RecipeJson {

        let simpleRecipeJson = RecipeJson(
            identifier: 1,
            name: "Bolo de tangerina",
            imageURL: "",
            difficultyLevel: 2,
            servings: 8,
            prepTime: 720,
            ingredients: [
                "200 gramas de açúcar refinado",
                "Raspas de três tangerinas",
                "150 gramas de suco de tangerina",
                "150 gramas de ovos"
            ],
            categories: [
                "Doces",
                "Bolos"
            ],
            rate: 5,
            steps: [
                StepJson(
                    step: 1,
                    stepDescription: "Unte com manteiga e farinha de trigo uma forma de 20 centímetros de diâmetro.",
                    hasTimer: true,
                    timer: 600
                ),
                StepJson(
                    step: 2,
                    stepDescription: "Salpique com maizena.",
                    hasTimer: true,
                    timer: 60
                )
            ]
        )
        return simpleRecipeJson
    }

}
