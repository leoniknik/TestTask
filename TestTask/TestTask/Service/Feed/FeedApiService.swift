//
//  FeedApiService.swift
//  TestTask
//
//  Created by Кирилл Володин on 03.11.2021.
//

import Foundation

enum ApiServiceError: Error {
    case parsing
    case request
}

protocol FeedApiServiceProtocol {
    func obtainPhotos(
        tags: String,
        page: Int,
        batchSize: Int,
        completion: @escaping (Result<PhotoFeedDTO, ApiServiceError>) -> ()
    )
}

final class FeedApiService {
    private let scheme: ApiScheme
    private let decoder: JSONDecoder
    private let networkService: NetworkServiceProtocol
    
    init(scheme: ApiScheme, networkService: NetworkServiceProtocol, decoder: JSONDecoder = JSONDecoder()) {
        self.networkService = networkService
        self.decoder = decoder
        self.scheme = scheme
    }
}

extension FeedApiService: FeedApiServiceProtocol {
    func obtainPhotos(
        tags: String,
        page: Int,
        batchSize: Int,
        completion: @escaping (Result<PhotoFeedDTO, ApiServiceError>) -> ()
    ) {
        let params = [
            "api_key": scheme.apiKey,
            "method": scheme.photosSearchMethod,
            "tags": tags,
            "format": "json",
            "nojsoncallback": "true",
            "extras": "media,url_sq,url_m",
            "per_page": "\(batchSize)",
            "page": "\(page)"
        ]
        guard let request = Request(url: scheme.baseAPIURL, method: .get, queryParameters: params).asURLRequest() else {
            completion(.failure(.request))
            return
        }
        networkService.sendRequest(request: request) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(data):
                guard let model = try? self.decoder.decode(PhotoFeedDTO.self, from: data) else {
                    completion(.failure(.parsing))
                    return
                }
                completion(.success(model))
            case .failure:
                completion(.failure(.request))
            }
        }
    }
}
