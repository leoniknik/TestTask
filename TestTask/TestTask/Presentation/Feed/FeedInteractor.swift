//
//  FeedInteractor.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import Foundation

protocol FeedBusinessLogic {
    func didSearch(text: String)
    func didSelectItem(with index: Int)
}

protocol FeedModuleInput {
}

protocol FeedModuleOutput: AnyObject {
    func didSelect(photo: Photo)
}


final class FeedInteractor {
    private weak var output: FeedModuleOutput?
    private let presenter: FeedPresentationLogic
    private let feedService: FeedServiceProtocol
    private let page = 1
    private let batchSize = 20
    private var photos: [Photo] = []
    
    init(output: FeedModuleOutput, presenter: FeedPresentationLogic, feedService: FeedServiceProtocol) {
        self.output = output
        self.presenter = presenter
        self.feedService = feedService
    }
}

extension FeedInteractor: FeedBusinessLogic {
    func didSelectItem(with index: Int) {
        let photo = photos[index]
        output?.didSelect(photo: photo)
    }
    
    func didSearch(text: String) {
        presenter.present(isLoading: true)
        feedService.obtainPhotos(tags: text, page: page, batchSize: batchSize) { [weak self] result in
            switch result {
            case let .success(photos):
                self?.photos = photos
                self?.presenter.present(isLoading: false)
                self?.presenter.presentPhotos(photos)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
}

extension FeedInteractor: FeedModuleInput {
    
}
