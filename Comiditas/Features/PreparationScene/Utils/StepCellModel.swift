//
//  SimpleStepModel.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation

enum StepCellModel {
    case simpleStep(text: String)
    case stepWithTimer(text: String, time: TimeInterval)

    var time: TimeInterval? {
        switch self {
        case .simpleStep(_): return nil
        case .stepWithTimer(_, let time): return time
        }
    }
}
