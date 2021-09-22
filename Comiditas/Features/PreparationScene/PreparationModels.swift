//
//  PreparationModels.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//
//swiftlint:disable nesting

import Foundation

enum PreparationModels {

    // MARK: Use Cases

    enum GetSteps {
        struct Request {
            let recipeIdentifier: Int
        }
        struct Response {
            let steps: [StepJson]
        }
        struct ViewModel {
            let steps: [StepCellModel]
        }
    }

    enum NextStep {
        struct Request {
            let currentIndexPath: IndexPath
        }
        struct Response {
            let nextIndexPath: IndexPath
        }
        struct ViewModel {
            let indexPath: IndexPath
        }
    }

    enum PreviousStep {
        struct Request {
            let currentIndexPath: IndexPath
        }
        struct Response {
            let previousIndexPath: IndexPath
        }
        struct ViewModel {
            let indexPath: IndexPath
        }
    }

    enum Finished {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

}
