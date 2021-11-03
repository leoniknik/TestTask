//
//  FeedCoordinatorComponent.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import NeedleFoundation

protocol FeedCoordinatorDependency: Dependency {
    
}

protocol FeedCoordinatorComponentProtocol {
    var feedComponent: FeedComponentProtocol { get }
}

final class FeedCoordinatorComponent: Component<FeedCoordinatorDependency> {
    
}
 
extension FeedCoordinatorComponent: FeedCoordinatorComponentProtocol {
    var feedComponent: FeedComponentProtocol { FeedComponent(parent: self) }
}
