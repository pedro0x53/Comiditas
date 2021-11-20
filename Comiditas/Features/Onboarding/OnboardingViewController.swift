//
//  OnboardingViewController.swift
//  Comiditas
//
//  Created by Alley Pereira on 18/11/21.
//

import UIKit

protocol OnboardingDisplayLogic: AnyObject {
    func displayNext(viewModel: OnboardingModel.NextStep.ViewModel)
    func displayEnd(viewModel: OnboardingModel.End.ViewModel)
}

typealias OnboardingStep = (image: UIImage?, text: String)

class OnboardingViewController: UIViewController, OnboardingDisplayLogic {

    var coordinator: OnboardingCoordinator?
    var interactor: OnboardingBusinessLogic?

    var index: Int = -1
    let steps: [OnboardingStep] = [
        (
            image: UIImage(named: "megafone"),
            text: OnboardingLocalizable.megafone01.text
        ),
        (
            image: UIImage(named: "01"),
            text: OnboardingLocalizable.text01.text
        ),
        (
            image: UIImage(named: "02"),
            text: OnboardingLocalizable.text02.text
        ),
        (
            image: UIImage(named: "03"),
            text: OnboardingLocalizable.text03.text
        ),
        (
            image: UIImage(named: "04"),
            text: OnboardingLocalizable.text04.text
        ),
        (
            image: UIImage(named: "megafone"),
            text: OnboardingLocalizable.megafone02.text
        )
    ]

    // MARK: - View
    lazy var onboardingView: OnboardingView = {
        let view = OnboardingView(frame: UIScreen.main.bounds)
        view.delegate = self
        return view
    }()

    // MARK: - Setup VIP
    func setupVIP() {
        let viewController = self
        let interactor = OnboardingInteractor()
        let presenter = OnboardingPresenter()

        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    // MARK: - View Cycle

    override func loadView() {
        super.loadView()
        self.view = onboardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextStep()
    }

    // MARK: - Calling Use Cases
    func nextStep() {
        let request = OnboardingModel.NextStep.Request(
            steps: steps,
            index: index
        )
        interactor?.requestNextStep(request: request)
    }

    func endOnboarding() {
        let request = OnboardingModel.End.Request()
        interactor?.requestEnd(request: request)
    }

    // MARK: - Display

    func displayNext(viewModel: OnboardingModel.NextStep.ViewModel) {
        if viewModel.isLastStep {
            endOnboarding()
        } else {
            self.index = viewModel.index
            onboardingView.onboardingLabel.text = viewModel.title
            onboardingView.onboardingImageView.image = viewModel.image
        }
    }

    func displayEnd(viewModel: OnboardingModel.End.ViewModel) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension OnboardingViewController: NextOrSkipOnboardingDelegate {

    func nextButton() {
        nextStep()
    }

    func skipButton() {
        endOnboarding()
    }

}
