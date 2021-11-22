//
//  SettingsLocalizable.swift
//  Comiditas
//
//  Created by Brena Amorim on 03/11/21.
//

import Foundation

enum SettingsLocalizable: String {
    case title

    case headerStepsTitle
    case voiceCommands
    case lockscreen
    case notifications
}

extension SettingsLocalizable: LocalizablesProtocol {
    var identifier: String { rawValue }
    var bundle: Bundle? { Bundle.main }
    var arguments: [String]? { nil }
    var tableName: String? { "Settings" }
    var defaultValue: String { "" }
}
