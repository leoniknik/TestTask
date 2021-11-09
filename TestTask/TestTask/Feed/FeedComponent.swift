//
//  FeedComponent.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import NeedleFoundation

protocol FeedDependency: Dependency {
    var networkService: NetworkServiceProtocol { get }
}

protocol FeedComponentProtocol {
    var feedService: FeedServiceProtocol { get }
}

final class FeedComponent: Component<FeedDependency> {
    
}
 
extension FeedComponent: FeedComponentProtocol {
    var feedService: FeedServiceProtocol {
        FeedService(apiService: FeedApiService(scheme: ApiScheme(), networkService: dependency.networkService))
    }
}
