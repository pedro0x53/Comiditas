//
//  FeedModels.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 21/09/21.
//

import Foundation

enum Feed {
    struct Response {
        let recipes: [RecipeJson]
    }

    struct ViewModel {
        let recipes: [RecipeJson]
    }

}

enum Recommendations {
    struct Response {
        let recipes: DailySpecial
    }

    struct ViewModel {
        let recipes: DailySpecial
    }

}
