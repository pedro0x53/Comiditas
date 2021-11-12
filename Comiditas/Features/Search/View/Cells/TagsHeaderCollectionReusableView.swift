//
//  TagsHeaderCollectionReusableView.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 05/11/21.
//

import UIKit

class TagsHeaderCollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var headerLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.h3
        label.numberOfLines = 0
        label.textColor = Colors.textDark
        label.text = "Header"
        label.isAccessibilityElement = true
        label.accessibilityTraits = .header
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setupUI() {
        self.backgroundColor = Colors.background
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
