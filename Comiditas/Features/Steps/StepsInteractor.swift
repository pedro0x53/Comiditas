//
//  StepsInteractor.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit

protocol StepsBusinessLogic {
    func requestSteps(request: StepModels.GetSteps.Request)
    func requestNextStep(request: StepModels.NextStep.Request)
    func requestPreviousStep(request: StepModels.PreviousStep.Request)
    func requestFinished(request: StepModels.Finished.Request)
}

class StepsInteractor: StepsBusinessLogic {

    var presenter: StepsPresentationLogic?
    var worker: StepsWorker = StepsWorker()

    func requestSteps(request: StepModels.GetSteps.Request) {

        let steps: [StepJson] = worker.readSteps(from: request.recipe)
        let response = StepModels.GetSteps.Response(steps: steps)

        presenter?.presentSteps(response: response)
    }

    func requestNextStep(request: StepModels.NextStep.Request) {
        let steps: [StepJson] = worker.readSteps(from: request.recipe)
        let nextIndex = request.currentIndex + 1
        let nextStep = steps[nextIndex]

        let stepPreview = (nextIndex == steps.count - 1) ? nil : steps[nextIndex + 1].stepDescription

        let response = StepModels.NextStep.Response(
            nextStep: nextStep,
            stepPreview: stepPreview
        )
        presenter?.presentNextStep(response: response)
    }

    func requestPreviousStep(request: StepModels.PreviousStep.Request) {
        let steps: [StepJson] = worker.readSteps(from: request.recipe)
        let previousIndex = request.currentIndex - 1
        let previousStep = steps[previousIndex]

        let stepPreview = (previousIndex == steps.count - 1) ? nil : steps[previousIndex + 1].stepDescription

        let response = StepModels.PreviousStep.Response(
            previousStep: previousStep,
            stepPreview: stepPreview
        )
        presenter?.presentPreviousStep(response: response)
    }

    func requestFinished(request: StepModels.Finished.Request) {
        let response = StepModels.Finished.Response()
        presenter?.presentFinished(response: response)
    }
}
