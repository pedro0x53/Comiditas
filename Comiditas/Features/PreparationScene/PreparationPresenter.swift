//
//  PreparationPresenter.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation

protocol PreparationPresentationLogic {
    func presentSteps(response: PreparationModels.GetSteps.Response)
    func presentNextStep(response: PreparationModels.NextStep.Response)
    func presentPreviousStep(response: PreparationModels.PreviousStep.Response)
    func presentFinished(response: PreparationModels.Finished.Response)
}

class PreparationPresenter: PreparationPresentationLogic {

    weak var viewController: PreparationDisplayLogic?

    func presentSteps(response: PreparationModels.GetSteps.Response) {

        var stepCellModels: [StepCellModel] = []

        for step in response.steps {
            if step.hasTimer {
                let stepCellModel = StepCellModel.stepWithTimer(
                    text: step.stepDescription,
                    time: TimeInterval(step.timer)
                )
                stepCellModels.append(stepCellModel)
            } else {
                let stepCellModel = StepCellModel.simpleStep(text: step.stepDescription)
                stepCellModels.append(stepCellModel)
            }
        }

        let viewModel = PreparationModels.GetSteps.ViewModel(
            steps: stepCellModels
        )
        viewController?.displaySteps(viewModel: viewModel)
    }

    func presentNextStep(response: PreparationModels.NextStep.Response) {
        let viewModel = PreparationModels.NextStep.ViewModel(indexPath: response.nextIndexPath)
        viewController?.displayNextStep(viewModel: viewModel)
    }

    func presentPreviousStep(response: PreparationModels.PreviousStep.Response) {
        let viewModel = PreparationModels.PreviousStep.ViewModel(indexPath: response.previousIndexPath)
        viewController?.displayPreviousStep(viewModel: viewModel)
    }

    func presentFinished(response: PreparationModels.Finished.Response) {
        let viewModel = PreparationModels.Finished.ViewModel()
        viewController?.displayFinished(viewModel: viewModel)
    }
}
