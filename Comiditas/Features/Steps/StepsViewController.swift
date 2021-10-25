//
//  StepsViewController.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit

protocol StepsDisplayLogic: AnyObject {
    func displaySteps(viewmodel: StepModels.GetSteps.ViewModel)
    func displayNextStep(viewModel: StepModels.NextStep.ViewModel)
    func displayPreviousStep(viewModel: StepModels.PreviousStep.ViewModel)
    func displayFinished(viewModel: StepModels.Finished.ViewModel)
}

class StepsViewController: UIViewController {

    var coordinator: StepsCoordinator?
    var interactor: StepsBusinessLogic?

    var recipe: RecipeJson
    var image: UIImage?

    var steps: [StepCellModel] = []

    // MARK: - View

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
    }

    // MARK: - View Cycle

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Helper Methods

    // MARK: - Actions

    // MARK: - Request Use Cases
}

// MARK: - Display Use Cases
extension StepsViewController: StepsDisplayLogic {

    func displaySteps(viewmodel: StepModels.GetSteps.ViewModel) {
        print("Display Step")
    }

    func displayNextStep(viewModel: StepModels.NextStep.ViewModel) {
        print("Display Next Step")
    }

    func displayPreviousStep(viewModel: StepModels.PreviousStep.ViewModel) {
        print("Display Previous Step")
    }

    func displayFinished(viewModel: StepModels.Finished.ViewModel) {
        print("Display Finished")
    }

}
