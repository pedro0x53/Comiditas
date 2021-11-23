//
//  OnboardingPresenter.swift
//  Comiditas
//
//  Created by Alley Pereira on 18/11/21.
//

import Foundation

protocol OnboardingPresentationLogic {
    func presentNextStep(response: OnboardingModel.NextStep.Response)
    func presentEnd(response: OnboardingModel.End.Response)
}

class OnboardingPresenter: OnboardingPresentationLogic {

    weak var viewController: OnboardingDisplayLogic?

    func presentNextStep(response: OnboardingModel.NextStep.Response) {

        let viewModel = OnboardingModel.NextStep.ViewModel(
            index: response.newIndex,
            title: response.nexStep.text,
            image: response.nexStep.image,
            isLastStep: response.isLastStep
        )
        viewController?.displayNext(viewModel: viewModel)
    }

    func presentEnd(response: OnboardingModel.End.Response) {
        let viewModel = OnboardingModel.End.ViewModel()
        viewController?.displayEnd(viewModel: viewModel)
    }

}
