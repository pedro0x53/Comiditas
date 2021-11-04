//
//  StepsInteractorTests.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 04/11/21.
//

import XCTest
@testable import Comiditas

class StepsInteractorTests: XCTestCase {

    // MARK: Subject under test
    var sut: StepsInteractor!

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        setupStepsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupStepsInteractor() {
        sut = StepsInteractor()
    }

    // MARK: Test doubles

    class StepsPresentationLogicSpy: StepsPresentationLogic {

        // MARK: Method call expectations

        var presentStepsCalled = false
        var presentNextStepCalled = false
        var presentPreviousStepCalled = false
        var presentFinishedCalled = false

        func presentSteps(response: StepModels.GetSteps.Response) {
            presentStepsCalled = true
        }

        func presentNextStep(response: StepModels.NextStep.Response) {
            presentNextStepCalled = true
        }

        func presentPreviousStep(response: StepModels.PreviousStep.Response) {
            presentPreviousStepCalled = true
        }

        func presentFinished(response: StepModels.Finished.Response) {
            presentFinishedCalled = true
        }

        // MARK: - Tests
    }
}
