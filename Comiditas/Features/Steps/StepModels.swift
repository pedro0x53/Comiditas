//
//  StepModels.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

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
            let steps: [StepCellModel]
        }
    }

    enum NextStep {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

    enum PreviousStep {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

    enum Finished {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}
