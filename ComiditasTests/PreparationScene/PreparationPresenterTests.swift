//
//  PreparationPresenterTests.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 29/09/21.
//

import XCTest
@testable import Comiditas

class PreparationPresenterTests: XCTestCase {

    // MARK: - Subject under test

    var sut: PreparationPresenter!

    // MARK: - Test lifecycle

    override func setUp() {
      super.setUp()
      setupShowPreparationPresenter()
    }

    override func tearDown() {
      super.tearDown()
    }

    // MARK: - Test setup

    func setupShowPreparationPresenter() {
      sut = PreparationPresenter()
    }

    class PreparationDisplayLogicSpy: PreparationDisplayLogic {

        // MARK: Method call expectations

        var displayStepsCalled = false
        var displayNextStepCalled = false
        var displayPreviousStepCalled = false
        var displayFinishedCalled = false

        // MARK: Argument expectations

        var viewModelGetSteps: PreparationModels.GetSteps.ViewModel!
        var viewModelNextStep: PreparationModels.NextStep.ViewModel!
        var viewModelPreviousStep: PreparationModels.PreviousStep.ViewModel!
        var viewModelFinished: PreparationModels.Finished.ViewModel!

        func displaySteps(viewModel: PreparationModels.GetSteps.ViewModel) {
            displayStepsCalled = true
            self.viewModelGetSteps = viewModel
        }

        func displayNextStep(viewModel: PreparationModels.NextStep.ViewModel) {
            displayNextStepCalled = true
            self.viewModelNextStep = viewModel
        }

        func displayPreviousStep(viewModel: PreparationModels.PreviousStep.ViewModel) {
            displayPreviousStepCalled = true
            self.viewModelPreviousStep = viewModel
        }

        func displayFinished(viewModel: PreparationModels.Finished.ViewModel) {
            displayFinishedCalled = true
            self.viewModelFinished = viewModel
        }

        // MARK: - Tests
    }
}
