//
//  StepsPresenterTests.swift
//  ComiditasTests
//
//  Created by Alley Pereira on 04/11/21.
//

import XCTest
@testable import Comiditas

class StepsPresenterTests: XCTestCase {

    // MARK: - Subject under test

    var sut: StepsPresenter!

    // MARK: - Test lifecycle

    override func setUp() {
      super.setUp()
      setupShowStepsPresenter()
    }

    override func tearDown() {
      super.tearDown()
    }

    // MARK: - Test setup
    func setupShowStepsPresenter() {
        sut = StepsPresenter()
    }

    class StepsDisplayLogicSpy: StepsDisplayLogic {

        // MARK: Method call expectations

        var displayStepsCalled = false
        var displayNextStepCalled = false
        var displayPreviousStepCalled = false
        var displayFinishedCalled = false

        // MARK: Argument expectations

        var viewModelGetSteps: StepModels.GetSteps.ViewModel!
        var viewModelNextStep: StepModels.NextStep.ViewModel!
        var viewModelPreviousStep: StepModels.PreviousStep.ViewModel!
        var viewModelFinished: StepModels.Finished.ViewModel!

        func displaySteps(viewModel: StepModels.GetSteps.ViewModel) {
            displayStepsCalled = true
            self.viewModelGetSteps = viewModel
        }

        func displayNextStep(viewModel: StepModels.NextStep.ViewModel) {
            displayNextStepCalled = true
            self.viewModelNextStep = viewModel
        }

        func displayPreviousStep(viewModel: StepModels.PreviousStep.ViewModel) {
            displayPreviousStepCalled = true
            self.viewModelPreviousStep = viewModel
        }

        func displayFinished(viewModel: StepModels.Finished.ViewModel) {
            displayFinishedCalled = true
            self.viewModelFinished = viewModel
        }

        // MARK: - Tests

    }

}
