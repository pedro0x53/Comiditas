//
//  StepsPresenter.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import Foundation

protocol StepsPresentationLogic {
    func presentSteps(response: StepModels.GetSteps.Response)
    func presentNextStep(response: StepModels.NextStep.Response)
    func presentPreviousStep(response: StepModels.PreviousStep.Response)
    func presentFinished(response: StepModels.Finished.Response)
}

class StepsPresenter: StepsPresentationLogic {

    weak var viewController: StepsDisplayLogic?

    func presentSteps(response: StepModels.GetSteps.Response) {
        if let firstStep = response.steps.first {

            let viewModel = StepModels.GetSteps.ViewModel(
                currentStep: firstStep,
                stepPreview: response.steps.count > 1 ? response.steps[1].stepDescription : nil,
                totalSteps: response.steps.count
            )

            viewController?.displaySteps(viewModel: viewModel)
        }
    }

    func presentNextStep(response: StepModels.NextStep.Response) {
        let viewModel = StepModels.NextStep.ViewModel(
            nextStep: response.nextStep,
            stepPreview: response.stepPreview
        )
        viewController?.displayNextStep(viewModel: viewModel)
    }

    func presentPreviousStep(response: StepModels.PreviousStep.Response) {
        let viewModel = StepModels.PreviousStep.ViewModel(
            previousStep: response.previousStep,
            stepPreview: response.stepPreview
        )
        viewController?.displayPreviousStep(viewModel: viewModel)
    }

    func presentFinished(response: StepModels.Finished.Response) {
        let viewModel = StepModels.Finished.ViewModel()
        viewController?.displayFinished(viewModel: viewModel)
    }
}
