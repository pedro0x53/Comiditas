//
//  StepsView.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit

class StepsView: UIView {

    // MARK: - Views
    let timerView: TimerView = TimerView()
    let nextStepView: StepPreviewView = StepPreviewView()

    lazy var stackView: NextAndPreviousStackView = NextAndPreviousStackView()

    lazy var recipeStepLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h4
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.textDark
        return label
    }()

    lazy var backgroundLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.image = UIImage(named: "line_up")
        return imageView
    }()

    // MARK: View Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Timer configurations
    func setupTimer(duration: TimeInterval) {
        timerView.setupTimer(duration: duration)
    }

    // MARK: - Setup Layout

    func createSubviews() {
        self.addSubview(backgroundLineImageView)
        self.addSubview(timerView)
        self.addSubview(recipeStepLabel)
        self.addSubview(nextStepView)
        self.addSubview(stackView)

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

    }

    //swiftlint:disable function_body_length
    func setupLayout() {

        NSLayoutConstraint.activate([
            recipeStepLabel.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 35
            ),
            recipeStepLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 16),
            recipeStepLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -16),
            recipeStepLabel.bottomAnchor.constraint(
                lessThanOrEqualTo: self.bottomAnchor,
                constant: -20),

            backgroundLineImageView.centerYAnchor.constraint(
                equalTo: self.centerYAnchor,
                constant: 35
            ),
            backgroundLineImageView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            backgroundLineImageView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),

            timerView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            timerView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            timerView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 0.4
            ),
            timerView.centerYAnchor.constraint(
                equalTo: backgroundLineImageView.centerYAnchor
            ),

            nextStepView.bottomAnchor.constraint(
                equalTo: stackView.topAnchor,
                constant: -35
            ),
            nextStepView.leadingAnchor.constraint(
                equalTo: recipeStepLabel.leadingAnchor
            ),
            nextStepView.trailingAnchor.constraint(
                equalTo: recipeStepLabel.trailingAnchor
            ),

            stackView.heightAnchor.constraint(
                lessThanOrEqualToConstant: 30),
            stackView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -10),
            stackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -16)

        ])
    }

    func setupLine(for index: Int) {
        if index % 2 == 0 {
            self.backgroundLineImageView.image = UIImage(named: "line_up")
        } else {
            self.backgroundLineImageView.image = UIImage(named: "line_down")
        }
    }

}
