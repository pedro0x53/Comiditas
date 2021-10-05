//
//  PreparationView.swift
//  Comiditas
//
//  Created by Alley Pereira on 21/09/21.
//

import UIKit

protocol PreparationViewDelegate: AnyObject {
    func didPressNextButton(indexPath: IndexPath)
    func didPressPreviousButton(indexPath: IndexPath)
    func didFinish()
}

class PreparationView: UIView {

    weak var delegate: PreparationViewDelegate?

    var steps: [StepCellModel] = [] {
        didSet {
            collectionView.reloadData()
            totalPagesLabel.text = " de \(steps.count)"
        }
    }

    var indexPathOnScreen: IndexPath!

    // MARK: - Views
    private var flowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }

    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.isAccessibilityElement = false
        collection.register(
            StepWithTimerCell.self,
            forCellWithReuseIdentifier: StepWithTimerCell.identifier
        )
        collection.register(
            SimpleStepCell.self,
            forCellWithReuseIdentifier: SimpleStepCell.identifier
        )
        return collection
    }()

    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(
            systemName: "chevron.left.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 45)
        )
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primary
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Passo anterior"
        button.addTarget(self, action: #selector(previousButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(
            systemName: "chevron.right.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 45)
        )
        button.setImage(image, for: .normal)
        button.tintColor = Colors.primary
        button.isAccessibilityElement = true
        button.accessibilityLabel = "Próximo passo"
        button.addTarget(self, action: #selector(nextButtonAction(_:)), for: .touchUpInside)
        return button
    }()

    let currentPageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h3
        label.textColor = Colors.primary
        label.textAlignment = .right
        return label
    }()

    let totalPagesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Fonts.h3Light
        label.textColor = Colors.primary
        label.textAlignment = .left
        return label
    }()

    private lazy var pageControlLabelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            currentPageLabel,
            totalPagesLabel
        ])
        stack.distribution = .equalCentering
        stack.spacing = 0
        return stack
    }()

    private lazy var bottomControlsStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                previousButton,
                pageControlLabelStack,
                nextButton
            ]
        )
        stack.distribution = .equalCentering
        return stack
    }()

    // MARK: - Selectors
    @objc func nextButtonAction(_ sender: UIButton) {
        if indexPathOnScreen.row == steps.count - 1 {
            delegate?.didFinish()
        } else {
            delegate?.didPressNextButton(indexPath: indexPathOnScreen)
        }
    }

    @objc func previousButtonAction(_ sender: UIButton) {
        if indexPathOnScreen.row > 0 {
            delegate?.didPressPreviousButton(indexPath: indexPathOnScreen)
        } else {
            print("Já está na primeira instrução")
        }
    }

    // MARK: - Object LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    func setupLayout() {
        self.addSubview(collectionView)
        self.addSubview(bottomControlsStackView)

        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            collectionView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 0.75
            ),
            collectionView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor
            ),

            bottomControlsStackView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -25
            ),
            bottomControlsStackView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 22
            ),
            bottomControlsStackView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -22
            )
        ])
    }

}

extension PreparationView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        steps.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let step: StepCellModel = steps[indexPath.row]

        switch step {
        case .stepWithTimer(let text, let time):
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: StepWithTimerCell.identifier,
                for: indexPath
            ) as? StepWithTimerCell {
                cell.setupTimer(duration: time)
                cell.recipeStepLabel.text = text
                cell.setupLine(for: indexPath)
                return cell
            }

        case .simpleStep(let text):
            if let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SimpleStepCell.identifier,
                for: indexPath
            ) as? SimpleStepCell {
                cell.recipeStepLabel.text = text
                cell.setupLine(for: indexPath)
                return cell
            }
        }

        return UICollectionViewCell(frame: .zero)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height * 0.75
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        indexPathOnScreen = indexPath
        currentPageLabel.text = "Passo \(indexPath.row + 1)"

        // Reset timer
        if let currentCell = cell as? StepWithTimerCell,
           let time = steps[indexPath.row].time {
            currentCell.setupTimer(duration: time)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath) {
        // Invalidate timer
        if let currentCell = cell as? StepWithTimerCell {
            currentCell.timerView.timerIsRunning = false
        }
    }

}
