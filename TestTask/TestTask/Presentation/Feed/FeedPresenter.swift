//
//  FeedPresenter.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import Foundation

protocol FeedPresentationLogic {
    func presentPhotos(_ photos: [Photo])
    func presentError()
    func present(isLoading: Bool)
}

final class FeedPresenter {
    weak var view: FeedDisplayLogic?
}

extension FeedPresenter: FeedPresentationLogic {
    func present(isLoading: Bool) {
        view?.display(isLoading: isLoading)
    }
    
    func presentPhotos(_ photos: [Photo]) {
        let photoViewModels: [FeedCell.ViewModel] = photos.compactMap {
            guard let url = URL(string: $0.urlSquare) else { return nil }
            return FeedCell.ViewModel(url: url)
        }
        view?.display(viewModel: .init(photos: photoViewModels))
    }
    
    func presentError() {
        
    }
}
