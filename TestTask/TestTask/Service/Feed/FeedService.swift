//
//  FeedService.swift
//  TestTask
//
//  Created by Кирилл Володин on 03.11.2021.
//

import Foundation

protocol FeedServiceProtocol {
    func obtainPhotos(tags: String, page: Int, batchSize: Int, completion: @escaping (Result<[Photo], Error>) -> ()) -> Cancelable
}

final class FeedService {
    private let queue = DispatchQueue(label: "com.testtask.feedservice", qos: .utility, attributes: .concurrent)
    private let apiService: FeedApiServiceProtocol
    
    init(apiService: FeedApiServiceProtocol) {
        self.apiService = apiService
    }
}

extension FeedService: FeedServiceProtocol {
    func obtainPhotos(tags: String, page: Int, batchSize: Int, completion: @escaping (Result<[Photo], Error>) -> ()) -> Cancelable {
        var job = DispatchWorkItem {}
        job = DispatchWorkItem { [weak self] in
            self?.apiService.obtainPhotos(tags: tags, page: page, batchSize: batchSize) { result in
                guard job.isCancelled == false else { return }
                switch result {
                case let .success(response):
                    let model = response.photos.photos.map { Photo(dto: $0) }
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        queue.async(execute: job)
        return job
    }
}
