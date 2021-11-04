//
//  StepModels.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//
// swiftlint:disable nesting

import UIKit

enum StepModels {

    // MARK: Use Cases

    enum GetSteps {
        struct Request {
            let recipe: RecipeJson
        }
        struct Response {
            let steps: [StepJson]
        }
        struct ViewModel {
            let currentStep: StepJson
            let stepPreview: String?
            let totalSteps: Int
        }
    }

    enum NextStep {
        struct Request {
            let recipe: RecipeJson
            let currentIndex: Int
        }
        struct Response {
            let nextStep: StepJson
            let stepPreview: String?
        }
        struct ViewModel {
            let nextStep: StepJson
            let stepPreview: String?
        }
    }

    enum PreviousStep {
        struct Request {
            let recipe: RecipeJson
            let currentIndex: Int
        }
        struct Response {
            let previousStep: StepJson
            let stepPreview: String?
        }
        struct ViewModel {
            let previousStep: StepJson
            let stepPreview: String?
        }
    }

    enum Finished {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}
