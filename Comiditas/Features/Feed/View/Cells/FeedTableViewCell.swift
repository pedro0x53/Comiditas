//
//  FeedTableViewCell.swift
//  Comiditas
//
//  Created by Beatriz Carlos on 26/10/21.
//

import UIKit

protocol FeedTableViewCellProtocol: AnyObject {
    func didSelectItemAt(recipe: RecipeJson)
}

class FeedTableViewCell: UITableViewCell {
    weak var delegate: FeedTableViewCellProtocol?
    var coordinator: FeedCoordinatorProtocol?
    var data: [RecipeJson] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 10, bottom: .zero, right: 10)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.9, height: 300)

        return layout
    }

    func reloadData() {
        collectionView.reloadData()
    }
}

extension FeedTableViewCell {
    func setupUI() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
}

extension FeedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "FeedCollectionViewCell",
                for: indexPath) as? FeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let url = URL(string: data[indexPath.row].imageURL) {
            cell.imageView.load(url: url)
        }

        cell.titleLabel.text = data[indexPath.row].name
        cell.titleLabel.accessibilityTraits = .staticText

        cell.labelPortion.text = "\(data[indexPath.row].servings) porções"
        cell.labelPortion.accessibilityTraits = .staticText

        let time = Time.secondsToHoursMinutesSeconds(seconds: data[indexPath.row].prepTime)
        cell.labelTime.text = Time.getString(for: time).accessible
        cell.labelTime.accessibilityTraits = .staticText
        cell.accessibilityLabel = [data[indexPath.row].name,
                                   "tempo de preparo de \(Time.getString(for: time).accessible)",
                                   "rendimento de \(data[indexPath.row].servings) porções"].joined(separator: " , ")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(recipe: data[indexPath.row])
    }
}

extension FeedTableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
