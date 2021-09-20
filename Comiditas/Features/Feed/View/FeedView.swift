//
//  FeedView.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

protocol FeedViewProtocol: AnyObject {
}

class FeedView: UIView {
    weak var delegate: FeedViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedView: BaseViewProtocol {
    func setupView() {
        self.backgroundColor = Colors.background
        setupConstraints()
    }

    func setupConstraints() {
    }
}
