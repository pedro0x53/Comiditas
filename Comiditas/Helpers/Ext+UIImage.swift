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
    }

    convenience init?(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}

// Remote image loader
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
