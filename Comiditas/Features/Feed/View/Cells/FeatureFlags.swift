//
//  FeatureFlags.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import Foundation

enum FeatureFlags: Int {
    case tagsFeed
    case user
    case currentStep
    case rating

    var isEnable: Bool {
        switch self {
        case .tagsFeed:
            return false
        case .user:
            return false
        case .currentStep:
            return false
        case .rating:
            return false
        }
    }
}
