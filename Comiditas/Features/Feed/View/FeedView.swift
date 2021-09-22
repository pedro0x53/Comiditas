//
//  FeedView.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

class FeedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var tagCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        collectionView.backgroundColor = Colors.background
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = !FeatureFlags.tagsFeed.isEnable
        return collectionView
    }()

    lazy var tableView: UITableView = {
        let height = FeatureFlags.user.isEnable ? 250 : 220
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Colors.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = CGFloat(height)
        return tableView
    }()

    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()

        layout.sectionInset = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        layout.itemSize = CGSize(width: Metrics.cellCollectionViewConstant.width,
                                 height: Metrics.cellCollectionViewConstant.height)

        return layout
    }
}

extension FeedView: BaseViewProtocol {
    private struct Metrics {
        static let tagCollectionView = (top: CGFloat(10), height: CGFloat(45))
        static let tableViewTop: CGFloat = 10
        static let cellCollectionViewConstant = (width: UIScreen.main.bounds.width * 0.30, height: CGFloat(40))
    }

    func setupView() {
        self.backgroundColor = Colors.background
        self.addSubview(tagCollectionView)
        self.addSubview(tableView)
        setupConstraints()
    }

    func setupConstraints() {
        if FeatureFlags.tagsFeed.isEnable {
            NSLayoutConstraint.activate([
                tagCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
                                                       constant: Metrics.tagCollectionView.top),
                tagCollectionView.heightAnchor.constraint(equalToConstant: Metrics.tagCollectionView.height),
                tagCollectionView.widthAnchor.constraint(equalTo: self.widthAnchor),

                tableView.topAnchor.constraint(equalTo: self.tagCollectionView.bottomAnchor,
                                               constant: Metrics.tableViewTop),
                tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
}
