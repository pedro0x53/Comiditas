//
//  TimerPreparationCollectionViewCell.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import Foundation
import UIKit

class TimerPreparationCollectionViewCell: UICollectionViewCell {

    static let identifier: String = "TimerPreparationCollectionViewCell"

    // MARK: - Property views

    let recipeStepLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h5
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.textColor = Colors.textDark
        return label
    }()

    let timerView: TimerView = TimerView()

    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.image = UIImage(named: "line_up")
        return imageView
    }()

    // MARK: - Object lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Timer

    func setupTimer(duration: TimeInterval) {
        timerView.setupTimer(duration: duration)
    }

    // MARK: - Setup Layout

    func setupLayout() {
        addSubviews()
        setupConstraints()
    }

    func addSubviews() {
        self.addSubview(recipeStepLabel)
        self.addSubview(backgroundImageView)
        self.addSubview(timerView)

        self.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func setupConstraints() {
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
                lessThanOrEqualTo: timerView.topAnchor,
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
            ),
            backgroundImageView.heightAnchor.constraint(
                equalToConstant: 200
            ),

            timerView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            timerView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            timerView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 0.5
            ),
            timerView.centerYAnchor.constraint(
                equalTo: self.backgroundImageView.centerYAnchor
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
