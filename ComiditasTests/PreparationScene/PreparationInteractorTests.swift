//
//  PreparationInteractorTests.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 29/09/21.
//

import XCTest
@testable import Comiditas

class PreparationInteractorTests: XCTestCase {

    // MARK: Subject under test

    var sut: PreparationInteractor!

    override func setUp() {
        super.setUp()
        setupPreparationInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupPreparationInteractor() {
        sut = PreparationInteractor()
    }

    // MARK: Test doubles

    class PreparationPresentationLogicSpy: PreparationPresentationLogic {

        // MARK: Method call expectations

        var presentStepsCalled = false
        var presentNextStepCalled = false
        var presentPreviousStepCalled = false
        var presentFinishedCalled = false

        // MARK: Spied methods

        func presentSteps(response: PreparationModels.GetSteps.Response) {
            presentStepsCalled = true
        }

        func presentNextStep(response: PreparationModels.NextStep.Response) {
            presentNextStepCalled = true
        }

        func presentPreviousStep(response: PreparationModels.PreviousStep.Response) {
            presentPreviousStepCalled = true
        }

        func presentFinished(response: PreparationModels.Finished.Response) {
            presentFinishedCalled = true
        }

        // MARK: - Tests
    }
}
