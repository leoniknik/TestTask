//
//  FeedView.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit
import SnapKit

final class FeedView: UIView {
    private let cellIdentifier = "\(FeedCell.self)"
    
    private lazy var layout: UICollectionViewLayout = {
        let fraction: CGFloat = 1 / 2
        let inset: CGFloat = 2
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(FeedCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func addSubviews() {
        add { collectionView }
    }
    
    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupStyle() {
        backgroundColor = .white
        collectionView.backgroundColor = .white
    }
}

extension FeedView: UICollectionViewDelegate {
    
}

extension FeedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? FeedCell else {
            fatalError()
        }
        return cell
    }
}
