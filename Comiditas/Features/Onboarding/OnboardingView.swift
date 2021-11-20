//
//  OnboardingView.swift
//  Comiditas
//
//  Created by Alley Pereira on 18/11/21.
//

import UIKit

protocol NextOrSkipOnboardingDelegate: AnyObject {
    func nextButton()
    func skipButton()
}

class OnboardingView: UIView {

    weak var delegate: NextOrSkipOnboardingDelegate?

    // MARK: - Views

    lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isAccessibilityElement = false
        return imageView
    }()

    lazy var onboardingLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h4
        label.textColor = Colors.textLight
        label.clipsToBounds = true
        label.isAccessibilityElement = true
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.tintColor = Colors.textLight
        button.setTitle(StepsLocalizable.skip.text, for: .normal)
        button.titleLabel?.font = Fonts.h6Bold
        button.isAccessibilityElement = true
        button.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = Colors.textLight
        button.setTitle(StepsLocalizable.next.text, for: .normal)
        button.titleLabel?.font = Fonts.h6Bold
        button.isAccessibilityElement = true
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()

    private lazy var skipAndNextButtonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            skipButton,
            nextButton
        ])
        stack.distribution = .equalCentering
        stack.spacing = 0
        return stack
    }()

    // MARK: View Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .black.withAlphaComponent(0.9)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Layout

    func setupView() {
        self.addSubview(onboardingImageView)
        self.addSubview(onboardingLabel)
        self.addSubview(skipAndNextButtonStackView)

        self.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            onboardingImageView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            onboardingImageView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            onboardingImageView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            onboardingImageView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 0.3
            ),

            onboardingLabel.topAnchor.constraint(
                equalTo: onboardingImageView.bottomAnchor,
                constant: 50
            ),
            onboardingLabel.centerXAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.centerXAnchor
            ),
            onboardingLabel.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: 0.9
            ),

            skipAndNextButtonStackView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -25
            ),
            skipAndNextButtonStackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 20
            ),
            skipAndNextButtonStackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -20
            )

        ])
    }

    // MARK: Actions

    @objc func skipButtonAction() {
        self.delegate?.skipButton()
    }

    @objc func nextButtonAction() {
        self.delegate?.nextButton()
    }

}
