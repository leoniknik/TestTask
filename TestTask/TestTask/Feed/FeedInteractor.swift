//
//  FeedInteractor.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import Foundation

protocol FeedBusinessLogic {
    func viewDidLoad()
    func didSearch(text: String)
}

protocol FeedModuleInput {
}

protocol FeedModuleOutput: AnyObject {
}


final class FeedInteractor {
    private weak var output: FeedModuleOutput?
    private let presenter: FeedPresentationLogic
    private let feedService: FeedServiceProtocol
    private let page = 1
    private let batchSize = 20
    
    init(output: FeedModuleOutput, presenter: FeedPresentationLogic, feedService: FeedServiceProtocol) {
        self.output = output
        self.presenter = presenter
        self.feedService = feedService
    }
}

extension FeedInteractor: FeedBusinessLogic {
    func viewDidLoad() {
    }
    
    func didSearch(text: String) {
        feedService.obtainPhotos(tags: text, page: page, batchSize: batchSize) { result in
            switch result {
            case let .success(photoDesctiptions):
                print(photoDesctiptions)
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension FeedInteractor: FeedModuleInput {
    
}
