//
//  OverviewModels.swift
//  Comiditas
//
//  Created by Pedro Sousa on 06/10/21.
//

import Foundation

struct Overview {
    struct Request {
        let recipe: RecipeJson
    }

    // MARK: Check the extension (line 26)
    struct Response {}

    // MARK: Check the extension (line 40)
    struct ViewModel {}
}

enum OverviewCopyType {
    case ingredients, direcions
}

extension Overview.Response {
    struct Share {
        let name: String
        let servings: String
        let ingredients: [String]
        let steps: [String]
    }

    struct Copy {
        let type: OverviewCopyType
        let content: [String]
    }
}

extension Overview.ViewModel {
    struct Recipe {
        let identifier: Int
        let name: String
        let imageURL: String
        let difficultyLevel: Int
        let servings: Int
        let prepTime: Int
        let ingredients: [String]
        let categories: [String]
        let rate: Int
        let steps: [StepJson]
    }

    struct Sharing {
        let content: String
    }
}
