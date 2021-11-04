//
//  StepsViewController.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit

protocol StepsDisplayLogic: AnyObject {
    func displaySteps(viewModel: StepModels.GetSteps.ViewModel)
    func displayNextStep(viewModel: StepModels.NextStep.ViewModel)
    func displayPreviousStep(viewModel: StepModels.PreviousStep.ViewModel)
    func displayFinished(viewModel: StepModels.Finished.ViewModel)
}

class StepsViewController: UIViewController {

    var coordinator: StepsCoordinator?
    var interactor: StepsBusinessLogic?

    var recipe: RecipeJson!
    var image: UIImage?

    // MARK: - View
    lazy var stepsView: StepsView = {
        let view = StepsView(frame: UIScreen.main.bounds)
        view.stackView.delegate = self
        return view
    }()

    // MARK: - Setup VIP
    func setUp() {
        let viewController = self
        let interactor = StepsInteractor()
        let presenter = StepsPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSteps()
    }

    // MARK: - View Cycle

    override func loadView() {
        super.loadView()
        self.view = stepsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
    }

    // MARK: - Helper Methods

    // MARK: - Actions

    // MARK: - Request Use Cases
    func fetchSteps() {
        let request = StepModels.GetSteps.Request(recipe: recipe)
        interactor?.requestSteps(request: request)
    }

    func goToNextInstruction(index: Int) {
        let request = StepModels.NextStep.Request(recipe: recipe, currentIndex: index)
        interactor?.requestNextStep(request: request)
    }

    func goToPreviousInstruction(index: Int) {
        let request = StepModels.PreviousStep.Request(recipe: recipe, currentIndex: index)
        interactor?.requestPreviousStep(request: request)
    }

    func requestFinished() {
        let request = StepModels.Finished.Request()
        interactor?.requestFinished(request: request)
    }
}

// MARK: - Display Use Cases
extension StepsViewController: StepsDisplayLogic {

    func displaySteps(viewModel: StepModels.GetSteps.ViewModel) {
        loadStep(viewModel.currentStep, preview: viewModel.stepPreview)
        stepsView.stackView.totalPagesLabel.text = " \(StepsLocalizable.of.text) \(viewModel.totalSteps)"
    }

    func displayNextStep(viewModel: StepModels.NextStep.ViewModel) {
        loadStep(viewModel.nextStep, preview: viewModel.stepPreview)
    }

    func displayPreviousStep(viewModel: StepModels.PreviousStep.ViewModel) {
        loadStep(viewModel.previousStep, preview: viewModel.stepPreview)
    }

    func displayFinished(viewModel: StepModels.Finished.ViewModel) {}

    private func loadStep(_ step: StepJson, preview: String?) {
        let hasTimer: Bool = step.hasTimer

        if hasTimer {
            stepsView.timerView.setupTimer(duration: TimeInterval(step.timer))
        }

        stepsView.recipeStepLabel.text = step.stepDescription
        stepsView.recipeStepLabel.font = hasTimer ? Fonts.h4 : Fonts.h4Bold
        stepsView.timerView.isHidden = !hasTimer
        stepsView.nextStepView.previewStepDescription = hasTimer ? nil : preview ?? nil
        stepsView.stackView.currentPageLabel.text = "\(StepsLocalizable.step.text) \(step.step)"
        stepsView.setupLine(for: step.step)
    }

}

extension StepsViewController: NextAndPreviousDelegate {
    func didPressNextButton(currentStepNumber: Int) {
        if stepsView.timerView.timerIsRunning {
            callAlert(okAction: { [weak self] in
                self?.stepsView.timerView.restartAction()
                self?.goToNextInstruction(index: currentStepNumber - 1)
            })
        } else {
            self.goToNextInstruction(index: currentStepNumber - 1)
        }
    }

    func didPressPreviousButton(currentStepNumber: Int) {
        if stepsView.timerView.timerIsRunning {
            callAlert(okAction: { [weak self] in
                self?.stepsView.timerView.restartAction()
                self?.goToPreviousInstruction(index: currentStepNumber - 1)
            })
        } else {
            goToPreviousInstruction(index: currentStepNumber - 1)
        }
    }

    func didFinish() {
        coordinator?.presentDidModal(
            with: image,
            title: ModalLocalizable.finished.text,
            description: recipe.name,
            closeButtonIsHidden: true, okAction: { [weak self] in
                self?.coordinator?.coordinateBack()
            })
    }

    func callAlert(okAction: @escaping () -> Void) {
        if let image = UIImage(named: "Attention") {
            coordinator?.presentDidModal(
                with: image,
                title: StepsLocalizable.alert.text,
                description: StepsLocalizable.alertStop.text,
                closeButtonIsHidden: false,
                okAction: okAction
            )
        }
    }

}
