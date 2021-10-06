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

    // MARK: Check the extension (line 27)
    struct Response {}

    struct ViewModel {
        let description: String
    }
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
