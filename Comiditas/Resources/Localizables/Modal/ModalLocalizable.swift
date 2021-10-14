//
//  ModalLocalizable.swift
//  Comiditas
//
//  Created by Alley Pereira on 14/10/21.
//

import Foundation

enum ModalLocalizable: String {
    case finished
    case imageDescriptionAcessibility
    case close
}

extension ModalLocalizable: LocalizablesProtocol {
    var identifier: String { rawValue }
    var bundle: Bundle? { Bundle.main }
    var arguments: [String]? { nil }
    var tableName: String? { "Modal" }
}
