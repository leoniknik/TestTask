//
//  FeedComponent.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import NeedleFoundation

protocol FeedDependency: Dependency {
    
}

protocol FeedComponentProtocol {
    
}

final class FeedComponent: Component<FeedDependency> {
    
}
 
extension FeedComponent: FeedComponentProtocol {
    
}
