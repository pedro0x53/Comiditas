//
//  SearchView.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 28/10/21.
//

import UIKit

protocol SearchViewProtocol: AnyObject {}

class SearchView: UIView {
    weak var delegate: SearchViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView: BaseViewProtocol {
    func setupView() {
        self.backgroundColor = Colors.background
        setupConstraints()
    }

    func setupConstraints() {}
}
