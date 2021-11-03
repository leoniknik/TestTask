//
//  FeedCell.swift
//  TestTask
//
//  Created by Кирилл Володин on 03.11.2021.
//

import UIKit

final class FeedCell: UICollectionViewCell {    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func setupStyle() {
        contentView.backgroundColor = .red
    }
}
