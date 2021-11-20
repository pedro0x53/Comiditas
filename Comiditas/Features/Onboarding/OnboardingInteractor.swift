//
//  OnboardingInteractor.swift
//  Comiditas
//
//  Created by Alley Pereira on 18/11/21.
//

import UIKit

protocol OnboardingBusinessLogic {
    func requestNextStep(request: OnboardingModel.NextStep.Request)
    func requestEnd(request: OnboardingModel.End.Request)
}

class OnboardingInteractor: OnboardingBusinessLogic {

    var presenter: OnboardingPresentationLogic?
    var worker: OnboardingWorker = OnboardingWorker()

    func requestNextStep(request: OnboardingModel.NextStep.Request) {
        let isLastStep = (request.index == request.steps.count - 1)

        let response = OnboardingModel.NextStep.Response(
            nexStep: request.steps[isLastStep ? request.index : request.index + 1],
            newIndex: request.index + 1,
            isLastStep: isLastStep
        )
        presenter?.presentNextStep(response: response)
    }

    func requestEnd(request: OnboardingModel.End.Request) {
        let response = OnboardingModel.End.Response()
        presenter?.presentEnd(response: response)

        //UserDefaults.standard.set(true, forKey: "showedOnboardingKey")
    }
}
