//
//  OverviewLocalizable.swift
//  Comiditas
//
//  Created by Pedro Sousa on 01/10/21.
//

import Foundation

enum OverviewLocalizable: String {
    case title
    case back

    case accessibleMainImage

    case servings
    case accessibleServings

    case accessiblePrep
    case minutes
    case hours

    case accessibleDifficulty
    case hard
    case medium
    case easy

    case rating
    case accessibleRating

    case ingredients

    case directions
    case step

    case startDirections
}

extension OverviewLocalizable: LocalizablesProtocol {
    var identifier: String { rawValue }
    var bundle: Bundle? { Bundle.main }
    var arguments: [String]? { nil }
    var tableName: String? { "Overview" }
}
