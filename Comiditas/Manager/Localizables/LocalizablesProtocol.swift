//
//  LocalizablesProtocol.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 30/09/21.
//

import Foundation

public protocol LocalizablesProtocol {
    // Identifier of string.
    var identifier: String { get }

    // Value of string already localized.
    var text: String { get }

    // Bundle to find where is located string file.
    var bundle: Bundle? { get }

    // Argument to replace %@ in string.
    var arguments: [String]? { get }

    // Comment to help future translations.
    var comment: String { get }

    // Default value if string can't be found.
    var defaultValue: String { get }

    // Name of .string file
    var tableName: String? { get }
}

public extension LocalizablesProtocol {
    var text: String {
        let stringLocalizable = NSLocalizedString(
            identifier,
            tableName: tableName,
            bundle: bundle ?? Bundle.main,
            value: defaultValue,
            comment: comment
        )

        let finalString = String(
            format: stringLocalizable,
            locale: Locale.current,
            arguments: arguments ?? []
        )

        return finalString
    }

    var comment: String { "" }
    var defaultValue: String { "" }
    var tableName: String { "" }
}
