//
//  StepsView.swift
//  Comiditas
//
//  Created by Alley Pereira on 25/10/21.
//

import UIKit

protocol StepsButtonDelegate: AnyObject {
    func dismissButton()
    func infoButton()
}

class StepsView: UIView {

    weak var delegate: StepsButtonDelegate?

    // MARK: - Views
    let timerView: TimerView = TimerView()
    let nextStepView: StepPreviewView = StepPreviewView()

    lazy var stackView: NextAndPreviousStackView = NextAndPreviousStackView()

    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "xmark.circle.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold))
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primary
        button.isAccessibilityElement = true
        button.accessibilityLabel = StepsLocalizable.close.text
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "info.circle.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold))
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primary
        button.isAccessibilityElement = true
        button.accessibilityLabel = StepsLocalizable.info.text
        button.addTarget(self, action: #selector(infoButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var recipeStepLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h4Bold
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
        configureAccessibilityElementsOrder()
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
        self.addSubview(closeButton)
        self.addSubview(infoButton)
        self.addSubview(backgroundLineImageView)
        self.addSubview(timerView)
        self.addSubview(recipeStepLabel)
        self.addSubview(nextStepView)
        self.addSubview(stackView)

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

    }

    func configureAccessibilityElementsOrder() {
        accessibilityElements = [
            closeButton,
            infoButton,
            stackView.bottomLabelsStackView,
            recipeStepLabel,
            timerView,
            nextStepView,
            stackView.previousButton,
            stackView.nextButton
        ]
    }

    func setupLayout() {
        self.backgroundColor = Colors.background

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                  constant: -18),
            closeButton.heightAnchor.constraint(equalToConstant: 45),

            infoButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            infoButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            infoButton.heightAnchor.constraint(equalTo: closeButton.heightAnchor),

            recipeStepLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 55),
            recipeStepLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            recipeStepLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            recipeStepLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -20),

            backgroundLineImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 35),
            backgroundLineImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundLineImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            timerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            timerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            timerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            timerView.centerYAnchor.constraint(equalTo: backgroundLineImageView.centerYAnchor),

            nextStepView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -35),
            nextStepView.leadingAnchor.constraint(equalTo: recipeStepLabel.leadingAnchor),
            nextStepView.trailingAnchor.constraint(equalTo: recipeStepLabel.trailingAnchor),

            stackView.heightAnchor.constraint(lessThanOrEqualToConstant: 30),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }

    func setupLine(for index: Int) {
        if index % 2 == 0 {
            self.backgroundLineImageView.image = UIImage(named: "line_up")
        } else {
            self.backgroundLineImageView.image = UIImage(named: "line_down")
        }
    }

    @objc func closeButtonAction() {
        self.delegate?.dismissButton()
    }

    @objc func infoButtonAction() {
        self.delegate?.infoButton()
    }

}
