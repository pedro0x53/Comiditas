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

    var isEnable: Bool {
        switch self {
        case .tagsFeed:
            return true
        case .user:
            return true
        }
    }
}
