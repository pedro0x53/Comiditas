//
//  Ext+UIImage.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 14/09/21.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case imgPortion
        case emptyImage
        case settingsicon
    }

    convenience init?(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}
