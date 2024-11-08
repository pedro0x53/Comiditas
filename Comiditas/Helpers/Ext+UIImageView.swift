//
//  Ext+UIImageView.swift
//  Comiditas
//
//  Created by Pedro Sousa on 20/09/21.
//

import UIKit

// Remote image loader
extension UIImageView {
    func load(url: URL, errorImage: UIImage? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                    completion?()
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = errorImage
                    completion?()
                }
            }
        }
    }
}
