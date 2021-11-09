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

struct Request {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    private let url: String
    private let queryParameters: [String: String]
    private let headers: [String: String]
    private let method: Method
    private let body: Data?
    
    init(
        url: String,
        method: Method,
        body: Data? = nil,
        headers: [String: String] = [:],
        queryParameters: [String: String] = [:]
    ) {
        self.url = url
        self.queryParameters = queryParameters
        self.body = body
        self.headers = headers
        self.method = method
    }
    
    func asURLRequest() -> URLRequest? {
        guard var components = URLComponents(string: url) else {
            return nil
        }
        var queryItems: [URLQueryItem] = []
        queryParameters.forEach { queryItems.append(URLQueryItem(name: $0.key, value: $0.value)) }
        components.queryItems = queryItems
        guard let url = components.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
