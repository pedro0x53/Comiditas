//
//  TagsCollectionViewCell.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 04/11/21.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.primary
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.isAccessibilityElement = false
        return view
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.font =  Fonts.h5
        label.textColor = Colors.textLight
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.accessibilityTraits = .button
        return label
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TagsCollectionViewCell {
    func setupUI() {
        contentView.addSubview(view)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            view.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
