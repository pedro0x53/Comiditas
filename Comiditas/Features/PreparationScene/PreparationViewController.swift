//
//  PreparationViewController.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import UIKit

protocol PreparationDisplayLogic: AnyObject {
    func displaySteps(viewModel: PreparationModels.GetSteps.ViewModel)
    func displayNextStep(viewModel: PreparationModels.NextStep.ViewModel)
    func displayPreviousStep(viewModel: PreparationModels.PreviousStep.ViewModel)
    func displayFinished(viewModel: PreparationModels.Finished.ViewModel)
}

class PreparationViewController: UIViewController {

    var coordinator: PreparationCoordinator?
    var interactor: PreparationBusinessLogic?

    var recipe: RecipeJson!

    var steps: [StepCellModel] = []

    // MARK: - View

    lazy var preparationView: PreparationView = {
        let view = PreparationView(frame: UIScreen.main.bounds)
        view.delegate = self
        return view
    }()

    // MARK: - Setup VIP

    func setup() {
        let viewController = self
        let interactor = PreparationInteractor()
        let presenter = PreparationPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - View Cycle

    override func loadView() {
        super.loadView()
        self.view = preparationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background

       swipeAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSteps()
    }

    // MARK: - Helper Methods

    private func createSwipeGestureRecognizer(
        for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {

        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))

        swipeGestureRecognizer.direction = direction

        return swipeGestureRecognizer
    }

    private func swipeAction() {
        preparationView.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        preparationView.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
    }

    // MARK: - Actions

    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {

        switch sender.direction {
        case .left:
            preparationView.nextButtonAction(UIButton())
        case .right:
            preparationView.previousButtonAction(UIButton())
        default:
            break
        }
    }

    // MARK: - Request Use Cases

    func fetchSteps() {
        let request = PreparationModels.GetSteps.Request(recipe: recipe)
        interactor?.requestSteps(request: request)
    }

    func goToNextInstruction(indexPath: IndexPath) {
        let request = PreparationModels.NextStep.Request(currentIndexPath: indexPath)
        interactor?.requestNextStep(request: request)
    }

    func goToPreviousInstruction(indexPath: IndexPath) {
        let request = PreparationModels.PreviousStep.Request(currentIndexPath: indexPath)
        interactor?.requestPreviousStep(request: request)
    }

    func requestFinished() {
        let request = PreparationModels.Finished.Request()
        interactor?.requestFinished(request: request)
    }
}

extension PreparationViewController: PreparationDisplayLogic {
    // MARK: - Display Use Cases

    func displaySteps(viewModel: PreparationModels.GetSteps.ViewModel) {
        preparationView.steps = viewModel.steps
    }

    func displayNextStep(viewModel: PreparationModels.NextStep.ViewModel) {
        preparationView.collectionView.selectItem(
            at: viewModel.indexPath,
            animated: true,
            scrollPosition: .centeredHorizontally
        )
    }

    func displayPreviousStep(viewModel: PreparationModels.PreviousStep.ViewModel) {
        preparationView.collectionView.selectItem(
            at: viewModel.indexPath,
            animated: true,
            scrollPosition: .centeredHorizontally
        )
    }

    func displayFinished(viewModel: PreparationModels.Finished.ViewModel) {}
}

extension PreparationViewController: PreparationViewDelegate {

    func callAlert(okAction: @escaping () -> Void) {
        if let image = UIImage(named: "Attention") {
            coordinator?.presentDidModal(
                with: image,
                title: StepsLocalizable.alertStop.text,
                okAction: okAction
            )
        }
    }

    func didPressNextButton(indexPath: IndexPath) {
        if let cell = preparationView.collectionView
                        .cellForItem(at: preparationView.indexPathOnScreen) as? StepWithTimerCell,
           cell.timerView.timerIsRunning {

            callAlert(okAction: { [weak self] in
                self?.goToNextInstruction(indexPath: indexPath)
            })

        } else {
            self.goToNextInstruction(indexPath: indexPath)
        }
    }

    func didPressPreviousButton(indexPath: IndexPath) {
        if let cell = preparationView.collectionView.cellForItem(
            at: preparationView.indexPathOnScreen
        ) as? StepWithTimerCell,
            cell.timerView.timerIsRunning {

            callAlert(okAction: { [weak self] in
                self?.goToPreviousInstruction(indexPath: indexPath)
            })

        } else {
            goToPreviousInstruction(indexPath: indexPath)
        }
    }

    func didFinish() {
        if let image = UIImage(named: "cakeImage") {
            coordinator?.presentDidModal(
                with: image,
                title: ModalLocalizable.finished.text,
                okAction: { [weak self] in
                    self?.coordinator?.coordinateBack()
                }
            )
        }
    }
}
