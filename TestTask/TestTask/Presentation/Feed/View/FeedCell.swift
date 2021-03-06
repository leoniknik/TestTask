//
//  FeedCell.swift
//  TestTask
//
//  Created by Кирилл Володин on 03.11.2021.
//

import Kingfisher
import UIKit

final class FeedCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                UIView.animate(withDuration: 0.2) {
                    self.contentView.alpha = 0.5
                } completion: { completed in
                    UIView.animate(withDuration: 0.2) {
                        self.contentView.alpha = 1
                    }
                }
            }
        }
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.kf.indicatorType = .activity
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func addSubviews() {
        contentView.add { imageView }
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupStyle() {
        contentView.backgroundColor = .white
    }
}

extension FeedCell {
    struct ViewModel {
        let url: URL
    }
    
    func configure(viewModel: ViewModel) {
        imageView.kf.setImage(with: viewModel.url)
    }
}
