//
//  Difficulty.swift
//  Comiditas
//
//  Created by Pedro Sousa on 22/09/21.
//

import Foundation

enum Difficulty: Int {
    case easy = 1
    case medium = 2
    case hard = 3

    var description: String {
        switch self {
        case .easy:
            return OverviewLocalizable.easy.text
        case .medium:
            return OverviewLocalizable.medium.text
        case .hard:
            return OverviewLocalizable.hard.text
        }
    }
}
