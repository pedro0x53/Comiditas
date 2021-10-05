//
//  RecipeHeaderCell.swift
//  Comiditas
//
//  Created by Pedro Sousa on 20/09/21.
//
// swiftlint:disable function_parameter_count

import UIKit

class RecipeHeaderCell: UITableViewCell, BaseViewProtocol {

    public static let identifier: String = "RecipeHeaderCellIdentifier"

    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.primary
        label.font = Fonts.h3
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let servingsLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h6
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let detailsStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let prepTimeItem: DetailView = DetailView(iconName: "clock.fill", description: "")
    private let difficultyItem: DetailView = DetailView(iconName: "flame.fill", description: "")
    private let rateItem: DetailView = DetailView(iconName: "star.fill", description: "")

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        contentView.addSubview(mainImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(servingsLabel)
        contentView.addSubview(detailsStack)

        detailsStack.addArrangedSubview(prepTimeItem)
        detailsStack.addArrangedSubview(difficultyItem)

        if FeatureFlags.rating.isEnable {
            detailsStack.addArrangedSubview(rateItem)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: 195),

            titleLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            servingsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            servingsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            servingsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            detailsStack.topAnchor.constraint(equalTo: servingsLabel.bottomAnchor, constant: 24),
            detailsStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            detailsStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            detailsStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    func configure(imageURL: String, title: String, servings: String,
                   prepTime: TimeResponse, difficulty: Difficulty, rating: Int) {
        if let url = URL(string: imageURL) {
            self.mainImage.load(url: url)
        }
        self.mainImage.accessibilityLabel = OverviewLocalizable.accessibleMainImage.text

        self.titleLabel.text = title
        self.titleLabel.accessibilityLabel = title

        self.servingsLabel.text = OverviewLocalizable.servings.text + servings
        self.servingsLabel.accessibilityLabel = OverviewLocalizable.accessibleServings.text + servings

        let prepTimeLabel = getPrepTimeLabel(for: prepTime)
        self.prepTimeItem.itemDescription = prepTimeLabel.display
        self.prepTimeItem.accessibilityLabel = OverviewLocalizable.accessiblePrep.text + prepTimeLabel.accessible

        let difficultyLabel = getDifficultyLabel(for: difficulty)
        self.difficultyItem.itemDescription = difficultyLabel
        self.difficultyItem.accessibilityLabel = OverviewLocalizable.accessibleDifficulty.text + difficultyLabel

        if FeatureFlags.rating.isEnable {
            self.rateItem.itemDescription = "\(rating)" + OverviewLocalizable.rating.text
            if Locale.current.languageCode == "pt_BR" {
                self.rateItem.accessibilityLabel = OverviewLocalizable.accessibleRating.text +
                                                   "\(rating)" + OverviewLocalizable.rating.text
            } else {
                self.rateItem.accessibilityLabel = "\(rating)" + OverviewLocalizable.accessibleRating.text
            }
        }

        self.accessibilityElements = [
            mainImage,
            titleLabel,
            servingsLabel,
            prepTimeItem,
            difficultyItem,
            rateItem
        ]
    }

    private func getDifficultyLabel(for difficulty: Difficulty) -> String {
        switch difficulty {
        case .easy:
            return OverviewLocalizable.easy.text
        case .medium:
            return OverviewLocalizable.medium.text
        case .hard:
            return OverviewLocalizable.hard.text
        }
    }

    private func getPrepTimeLabel(for time: TimeResponse) -> (display: String, accessible: String) {
        var displayPrepTime = ""
        var accessiblePrepTime = ""

        if time.hour > 0 {
            displayPrepTime += "\(time.hour)h "
            accessiblePrepTime += "\(time.hour)" + OverviewLocalizable.hours.text + " "
        }

        if time.minutes > 0 {
            displayPrepTime += "\(time.minutes)min"
            accessiblePrepTime += "\(time.minutes)" + OverviewLocalizable.minutes.text
        }

        return (displayPrepTime, accessiblePrepTime)
    }
}
