//
//  FeedTableViewCell.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 20/09/21.
//

import UIKit

protocol FeedTableViewCellProtocol: AnyObject {
    func didSelectItemAt(recipe: RecipeJson)
}

class FeedTableViewCell: UITableViewCell {
    weak var delegate: FeedTableViewCellProtocol?

    var data: [RecipeJson] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        setupUI()
    }

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "FeedCollectionViewCell")
        collectionView.backgroundColor = Colors.background
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let heightCV: CGFloat = FeatureFlags.user.isEnable ? 250 : 214

        layout.sectionInset = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.9, height: heightCV)

        return layout
    }

    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - UI Setup
extension FeedTableViewCell {
    private func setupUI() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
}

extension FeedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as? FeedCollectionViewCell
        else { return UICollectionViewCell() }

        if data.count > 0 {
            let recipe = data[indexPath.row]
            cell.titleLabel.text = recipe.name
            let time = Time.secondsToHoursMinutesSeconds(seconds: recipe.prepTime)
            cell.subtitleLabel.text = "\(time.minutes) minutos • \(recipe.servings) porções"
            if let url = URL(string: recipe.imageURL) {
                cell.imageView.load(url: url)
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(recipe: data[indexPath.row])
    }
}
