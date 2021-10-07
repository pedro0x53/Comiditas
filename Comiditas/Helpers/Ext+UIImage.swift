//
//  Ext+UIImage.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 14/09/21.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case exemple = "exemple"
        case icExemple = "ic_exemple"
        case imgPizza = "pizza"
    }

    convenience init?(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}
