// swiftlint:disable identifier_name
//  StepsLocalizable.swift
//  Comiditas
//
//  Created by Alley Pereira on 13/10/21.
//

import Foundation

enum StepsLocalizable: String {

    case recipe
    case step
    case of

    case alertStop
    case alertAtention
    case alertContinue
    case alertCancel

    case iniciateClockAcessibility
    case pauseClockAcessibility

    case backStep
    case nextStep
}

extension StepsLocalizable: LocalizablesProtocol {
    var identifier: String { rawValue }
    var bundle: Bundle? { Bundle.main }
    var arguments: [String]? { nil }
    var tableName: String? { "Steps" }
}