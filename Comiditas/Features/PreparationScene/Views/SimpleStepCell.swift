//
//  SimpleStepCell.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation
import UIKit

class SimpleStepCell: UICollectionViewCell {
    static let identifier: String = "SimpleStepCell"

    let recipeStepLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h5
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.textColor = Colors.textDark
        label.isAccessibilityElement = true
        return label
    }()

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.image = UIImage(named: "line_up")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        self.addSubview(recipeStepLabel)
        self.addSubview(backgroundImageView)
        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            recipeStepLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 46
            ),
            recipeStepLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 16
            ),
            recipeStepLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -16
            ),
            recipeStepLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: self.bottomAnchor,
                constant: -25
            ),

            backgroundImageView.centerYAnchor.constraint(
                equalTo: self.centerYAnchor,
                constant: 20
            ),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            )
        ])
    }

    func setupLine(for indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            self.backgroundImageView.image = UIImage(named: "line_up")
        } else {
            self.backgroundImageView.image = UIImage(named: "line_down")
        }
    }

}
