//
//  FeedLocalizables.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 30/09/21.
//

import Foundation

enum FeedLocalizable: String {
    case recommendedForYou
    case otherRecipes
    case candy
    case salted
    case subTitle
    case title
    case search
}

extension FeedLocalizable: LocalizablesProtocol {
    var identifier: String { rawValue }
    var bundle: Bundle? { Bundle.main }
    var arguments: [String]? { nil }
    var tableName: String? { "Feed" }
}
