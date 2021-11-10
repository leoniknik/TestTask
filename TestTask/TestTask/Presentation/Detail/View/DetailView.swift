//
//  DetailView.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import UIKit
import SnapKit

protocol DetailViewDelegate: AnyObject {
    func saveTapped()
}

final class DetailView: UIView {
    weak var delegate: DetailViewDelegate?
    var image: UIImage? { imageView.image }
    
    private var viewModel: ViewModel?
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.kf.indicatorType = .activity
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save to gallery", for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func addSubviews() {
        add {
            imageView
            saveButton
        }
    }
    
    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(8)
            make.bottom.equalTo(saveButton.snp.top).offset(-8)
        }

        saveButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(56)
        }
    }
    
    private func setupStyle() {
        backgroundColor = .white
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
    }
    
    @objc private func saveTapped() {
        guard imageView.image != nil else { return }
        delegate?.saveTapped()
    }
}

extension DetailView {
    struct ViewModel {
        let url: URL
    }
    
    func setup(viewModel: DetailView.ViewModel) {
        self.viewModel = viewModel
        imageView.kf.setImage(with: viewModel.url)
    }
}
