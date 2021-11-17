//
//  StepsViewController.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit
import Speech

protocol StepsDisplayLogic: AnyObject {
    func displaySteps(viewModel: StepModels.GetSteps.ViewModel)
    func displayNextStep(viewModel: StepModels.NextStep.ViewModel)
    func displayPreviousStep(viewModel: StepModels.PreviousStep.ViewModel)
    func displayFinished(viewModel: StepModels.Finished.ViewModel)
}

class StepsViewController: UIViewController {

    var coordinator: StepsCoordinator?
    var interactor: StepsBusinessLogic?

    var speechManager: SpeechManager?
    var stepIdentifier: Int = 0

    var recipe: RecipeJson!
    var image: UIImage?

    // MARK: - View
    lazy var stepsView: StepsView = {
        let view = StepsView(frame: UIScreen.main.bounds)
        view.stackView.delegate = self
        view.delegate = self
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSteps()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let speechStatus = SFSpeechRecognizer.authorizationStatus()
        let settingsSpeech = UserDefaults.standard.bool(forKey: "voiceCommands")

        if speechStatus == .notDetermined || (speechStatus == .authorized && settingsSpeech) {
            if speechStatus == .authorized {
                speechManager?.prepare(authorized: true)
            } else {
                speechManager?.prepare(authorized: false)
            }
        }
    }

    // MARK: - View Cycle

    override func loadView() {
        super.loadView()
        self.view = stepsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()

        let speechStatus = SFSpeechRecognizer.authorizationStatus()
        let settingsSpeech = UserDefaults.standard.bool(forKey: "voiceCommands")

        if speechStatus == .notDetermined || (speechStatus == .authorized && settingsSpeech) {
            speechManager = SpeechManager()
            speechManager?.delegate = self
        }
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
        stepsView.timerView.isHidden = !hasTimer
        stepsView.nextStepView.previewStepDescription = hasTimer ? nil : preview ?? nil
        stepsView.stackView.currentPageLabel.text = "\(StepsLocalizable.step.text) \(step.step)"
        stepsView.setupLine(for: step.step)

        newStepPresented()
    }

}

extension StepsViewController: NextAndPreviousDelegate {
    func didPressNextButton() {
        if stepIdentifier == recipe.steps.count - 1 {
            stepsView.timerView.timerIsRunning = false
            self.didFinish()
            return
        }

        if stepsView.timerView.timerIsRunning {
            callAlert(okAction: { [unowned self] in
                self.stepsView.timerView.restartAction()
                self.goToNextInstruction(index: self.stepIdentifier)
                self.stepIdentifier += 1
            })
        } else {
            self.goToNextInstruction(index: self.stepIdentifier)
            self.stepIdentifier += 1
        }
    }

    func didPressPreviousButton() {
        if stepsView.timerView.timerIsRunning {
            callAlert(okAction: { [unowned self] in
                self.stepsView.timerView.restartAction()
                if self.stepIdentifier > 0 {
                    self.goToPreviousInstruction(index: self.stepIdentifier)
                    self.stepIdentifier -= 1
                }
            })
        } else {
            if self.stepIdentifier > 0 {
                goToPreviousInstruction(index: self.stepIdentifier)
                self.stepIdentifier -= 1
            }
        }
    }

    private func newStepPresented() {
        if UserDefaults.standard.bool(forKey: "lockscreen") &&
            self.recipe.steps[stepIdentifier].timer < 300 {
            UIApplication.shared.isIdleTimerDisabled = true
        } else {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }

    func didFinish() {
        coordinator?.presentDidModal(
            with: image,
            title: ModalLocalizable.finished.text,
            description: recipe.name,
            closeButtonIsHidden: true, okAction: { [unowned self] in
                self.coordinator?.dismiss(animated: false)
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

extension StepsViewController: SpeechManagerDelegate {

    func speechManger(state: SpeechManagerState) {
        switch state {
        case .recognitionAvailable:
            guard let speechManager = speechManager else { return }
           speechManager.processor = DirectionsSpeechProcessor(manager: speechManager)
            speechManager.start()
        case .recognitionNotAvailable:
            speechManager = nil
        default:
            break
        }
    }
    func speechManger(_ identifier: Int, processedString string: String) {
        guard let speechCase = DirectionsSpeechProcessor.Patterns(rawValue: identifier) else {
            return
        }
        switch speechCase {
        case .none:
            return
        case .nextStep:
            didPressNextButton()
        case .previousStep:
            didPressPreviousButton()
        case .currentStep:
            guard let currentStepText = stepsView.recipeStepLabel.text else {
                return
            }
            speechManager?.speak(currentStepText)
        case .pauseTimer:
            stepsView.timerView.isTimerRunning = false
        case .resumeTimer:
            stepsView.timerView.isTimerRunning = true
        case .reiniciateTimer:
            stepsView.timerView.restartAction()
        }
    }

    func speechManger(error: SpeechRecognizer.SRError) {
        speechManager = nil
    }

}

extension StepsViewController: DismissDelegate {
    func dismissButton() {
        self.coordinator?.dismiss()
    }
}
