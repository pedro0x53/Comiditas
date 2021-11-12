//
//  Step.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 15/09/21.
//

import Foundation

struct StepJson: Codable {
    let step: Int
    let stepDescription: String
    let hasTimer: Bool
    let timer: Int
}
