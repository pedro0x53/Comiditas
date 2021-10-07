//
//  PreparationInterator.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation

protocol PreparationBusinessLogic {
    func requestSteps(request: PreparationModels.GetSteps.Request)
    func requestNextStep(request: PreparationModels.NextStep.Request)
    func requestPreviousStep(request: PreparationModels.PreviousStep.Request)
    func requestFinished(request: PreparationModels.Finished.Request)
}

class PreparationInteractor: PreparationBusinessLogic {

    var presenter: PreparationPresentationLogic?
    var worker: PreparationWorker = PreparationWorker()

    func requestSteps(request: PreparationModels.GetSteps.Request) {

        // chama o worker pra pegar os steps do Json
        var steps: [StepJson] = worker.readSteps(from: request.recipe)
        steps.sort { elementA, elementB in elementA.step < elementB.step }

        // cria um response
        let response = PreparationModels.GetSteps.Response(steps: steps)

        // manda response pro presenter
        presenter?.presentSteps(response: response)
    }

    func requestNextStep(request: PreparationModels.NextStep.Request) {
        let nextIndexPath = IndexPath(
            row: request.currentIndexPath.row + 1,
            section: request.currentIndexPath.section
        )
        let response = PreparationModels.NextStep.Response(nextIndexPath: nextIndexPath)
        presenter?.presentNextStep(response: response)
    }

    func requestPreviousStep(request: PreparationModels.PreviousStep.Request) {
        let previousIndexPath = IndexPath(
            row: request.currentIndexPath.row - 1,
            section: request.currentIndexPath.section
        )
        let response = PreparationModels.PreviousStep.Response(previousIndexPath: previousIndexPath)
        presenter?.presentPreviousStep(response: response)
    }

    func requestFinished(request: PreparationModels.Finished.Request) {
        let response = PreparationModels.Finished.Response()
        presenter?.presentFinished(response: response)
    }

}
