//
//  FeedView.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit
import SnapKit

protocol FeedViewDelegate: AnyObject {
    func didSelectItem(at indexPath: IndexPath)
}

final class FeedView: UIView {
    weak var delegate: FeedViewDelegate?
    
    private var viewModel = FeedView.ViewModel(photos: [])
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
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func setup(viewModel: FeedView.ViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    func display(isLoading: Bool) {
        isLoading ? activityView.startAnimating() : activityView.stopAnimating()
    }
    
    private func addSubviews() {
        add {
            collectionView
            activityView
        }
    }
    
    private func setupLayout() {
        activityView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupStyle() {
        backgroundColor = .white
        collectionView.backgroundColor = .white
        activityView.color = .gray
    }
}

extension FeedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(at: indexPath)
    }
}

extension FeedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? FeedCell else {
            fatalError()
        }
        let viewModel = viewModel.photos[indexPath.row]
        cell.configure(viewModel: viewModel)
        return cell
    }
}

extension FeedView {
    struct ViewModel {
        let photos: [FeedCell.ViewModel]
    }
}
