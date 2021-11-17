//
//  StepPreviewView.swift
//  Comiditas
//
//  Created by Alley Pereira on 27/10/21.
//

import UIKit

class StepPreviewView: UIView {

    var previewStepDescription: String? {
        didSet {
            if let description = previewStepDescription {
                self.isHidden = false
                nextStepDescriptionLabel.text = description
                groupAcessibilityLabels()
            } else {
                self.isHidden = true
            }
        }
    }

    // MARK: - Views
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = Colors.secondary
        return view
    }()

    private lazy var nextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h6Bold
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isAccessibilityElement = false
        label.text = "\(StepsLocalizable.next.text)\n"
        label.textColor = Colors.textDark
        return label
    }()

    private lazy var nextStepDescriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h6
        label.textAlignment = .left
        label.numberOfLines = 2
        label.isAccessibilityElement = false
        label.lineBreakMode = .byTruncatingTail
        label.text = previewStepDescription
        label.textColor = Colors.textDark
        return label
    }()

    func groupAcessibilityLabels() {
        self.isAccessibilityElement = true
        self.shouldGroupAccessibilityChildren = true
        guard let nextStepDescriptionLabel = nextStepDescriptionLabel.text else { return }
        guard let nextLabelText = nextLabel.text else { return }
        self.accessibilityLabel = [nextLabelText, nextStepDescriptionLabel].joined(separator: "\n")
    }

    // MARK: View Life cycle
    init() {
        super.init(frame: .zero)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        self.addSubview(backgroundView)
        self.addSubview(nextLabel)
        self.addSubview(nextStepDescriptionLabel)

        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 11

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            nextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            nextLabel.bottomAnchor.constraint(equalTo: nextStepDescriptionLabel.topAnchor),

            nextStepDescriptionLabel.leadingAnchor.constraint(equalTo: nextLabel.leadingAnchor),
            nextStepDescriptionLabel.trailingAnchor.constraint(equalTo: nextLabel.trailingAnchor),
            nextStepDescriptionLabel.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor,
                                                             constant: -10)
        ])
    }
}
