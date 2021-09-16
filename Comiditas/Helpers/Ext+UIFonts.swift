//
//  Ext+UIFonts.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 16/09/21.
//

import UIKit
// swiftlint:disable identifier_name
struct Fonts {
    static var h1: UIFont {
        return .rounded(ofSize: 45, weight: .bold)
    }

    static var h2: UIFont {
        return .rounded(ofSize: 34, weight: .bold)
    }

    static var h3: UIFont {
        return .rounded(ofSize: 22, weight: .bold)
    }

    static var h4: UIFont {
        return .rounded(ofSize: 20, weight: .bold)
    }

    static var h5: UIFont {
        return .rounded(ofSize: 17, weight: .medium)
    }

    static var h6: UIFont {
        return .rounded(ofSize: 17, weight: .regular)
    }

    static var h7: UIFont {
        return .rounded(ofSize: 15, weight: .medium)
    }
}

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}
