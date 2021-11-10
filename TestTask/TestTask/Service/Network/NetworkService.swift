//
//  NetworkService.swift
//  TestTask
//
//  Created by Кирилл Володин on 03.11.2021.
//

import Foundation

enum NetworkError: Error {
    case noData
}

protocol NetworkServiceProtocol {
    func sendRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> ())
}

final class NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NetworkService: NetworkServiceProtocol {
    func sendRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> ()) {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}

extension URLSessionDataTask: Cancelable {
    
}
