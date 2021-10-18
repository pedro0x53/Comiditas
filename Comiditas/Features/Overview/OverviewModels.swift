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
        var content: [String] = []
    }
}

extension Overview.ViewModel {
    struct Recipe {}

    struct Sharing {
        let content: String
    }
}
