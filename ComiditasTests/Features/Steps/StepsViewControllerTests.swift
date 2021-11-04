//
//  StepsViewControllerTests.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 04/11/21.
//

import XCTest
@testable import Comiditas

class StepsViewControllerTests: XCTestCase {

    var sut: StepsViewController!
    var window: UIWindow!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupStepsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupStepsViewController() {
        sut = StepsViewController(nibName: nil, bundle: nil)
        sut.recipe = setupBasicRecipeMOCK()

    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles

    class StepsBusinessLogicSpy: StepsBusinessLogic {

        // MARK: Method call expectations
        var requestStepsCalled = false
        var requestNextStepCalled = false
        var requestPreviousStepCalled = false
        var requestFinishedCalled = false

        // MARK: Argument expectations

        var requestStepsRequest: StepModels.GetSteps.Request!
        var requestNextStepRequest: StepModels.NextStep.Request!
        var requestPreviousStepRequest: StepModels.PreviousStep.Request!
        var requestFinishedRequest: StepModels.Finished.Request!

        func requestSteps(request: StepModels.GetSteps.Request) {
            requestStepsCalled = true
            self.requestStepsRequest = request
        }

        func requestNextStep(request: StepModels.NextStep.Request) {
            requestNextStepCalled = true
            self.requestNextStepRequest = request
        }

        func requestPreviousStep(request: StepModels.PreviousStep.Request) {
            requestPreviousStepCalled = true
            self.requestPreviousStepRequest = request
        }

        func requestFinished(request: StepModels.Finished.Request) {
            requestFinishedCalled = true
            self.requestFinishedRequest = request
        }
    }

    // MARK: Tests

    func testShoudFetchStepsWhenViewWillAppear() {
        // Given
        let stepsBusinessLogicSpy = StepsBusinessLogicSpy()
        sut.interactor = stepsBusinessLogicSpy

        // When
        loadView()

        // Then
        XCTAssert(stepsBusinessLogicSpy.requestStepsCalled,
                  "Should fetch recipes right after the view appears")
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
