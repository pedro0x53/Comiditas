//
//  NextAndPreviousStackView.swift
//  Comiditas
//
//  Created by Alley Pereira on 27/10/21.
//

import UIKit

protocol NextAndPreviousDelegate: AnyObject {
    func didPressNextButton(currentStepNumber: Int)
    func didPressPreviousButton(currentStepNumber: Int)
    func didFinish()
}

class NextAndPreviousStackView: UIStackView {

    weak var delegate: NextAndPreviousDelegate?

    private var stepNumber: Int {
        let lastCurrentStepChar = "\(currentPageLabel.text!.last!)"
        return Int(lastCurrentStepChar)!
    }

    private var totalStepsNumber: Int {
        let lastTotalStepsChar = "\(totalPagesLabel.text!.last!)"
        return Int(lastTotalStepsChar)!
    }

    // MARK: - Views
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(
            systemName: "chevron.forward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        )
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primary
        button.isAccessibilityElement = true
        button.accessibilityLabel =  StepsLocalizable.nextStep.text
        button.addTarget(self, action: #selector(nextButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
        )
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primary
        button.isAccessibilityElement = true
        button.accessibilityLabel = StepsLocalizable.backStep.text
        button.addTarget(self, action: #selector(previousButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    let currentPageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h3
        label.textColor = Colors.textDark
        label.textAlignment = .right
        return label
    }()

    let totalPagesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h3
        label.textColor = Colors.textDark
        label.textAlignment = .left
        return label
    }()

    private lazy var bottomLabelsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            currentPageLabel,
            totalPagesLabel
        ])
        stack.distribution = .equalCentering
        stack.spacing = 0
        return stack
    }()

    // MARK: - Object LifeCycle
    init() {
        super.init(frame: .zero)

        self.distribution = .equalCentering

        self.addArrangedSubview(previousButton)
        self.addArrangedSubview(bottomLabelsStackView)
        self.addArrangedSubview(nextButton)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selectors

    @objc func nextButtonAction(_ sender: UIButton) {
        if stepNumber == totalStepsNumber {
            delegate?.didFinish()
            HapticsManager.shared.vibrate(for: .success)
        } else {
            delegate?.didPressNextButton(currentStepNumber: stepNumber)
            HapticsManager.shared.vibrate(for: .success)
        }
    }

    @objc func previousButtonAction(_ sender: UIButton) {
        if stepNumber > 1 {
            let lastChar = "\(currentPageLabel.text!.last!)"
            let stepNumber = Int(lastChar)!
            delegate?.didPressPreviousButton(currentStepNumber: stepNumber)
            HapticsManager.shared.vibrate(for: .success)
        }
    }

}
