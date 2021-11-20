//
//  Onboarding.swift
//  Comiditas
//
//  Created by Alley Pereira on 19/11/21.
//

import Foundation

enum OnboardingLocalizable: String {

    case megafone01
    case text01
    case text02
    case text03
    case text04
    case megafone02
}

extension OnboardingLocalizable: LocalizablesProtocol {

    var identifier: String { rawValue }
    var bundle: Bundle? { Bundle.main }
    var arguments: [String]? { nil }
    var tableName: String? { "Onboarding" }
    var defaultValue: String { "" }
}
