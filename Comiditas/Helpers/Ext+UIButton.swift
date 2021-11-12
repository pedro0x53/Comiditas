//
//  Ext+UIButton.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 06/11/21.
//

import UIKit

extension UIButton {
    func addRightIcon(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)

        let length = CGFloat(15)
        titleEdgeInsets.right += length

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.titleLabel!.trailingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: self.titleLabel!.centerYAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: length),
            imageView.heightAnchor.constraint(equalToConstant: length)
        ])
    }
}
