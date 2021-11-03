//
//  ApplicationCoordinatorComponent.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import NeedleFoundation

protocol ApplicationComponentProtocol {
    var feedCoordinatorComponent: FeedCoordinatorComponentProtocol { get }
}

final class ApplicationComponent: BootstrapComponent {
}
 
extension ApplicationComponent: ApplicationComponentProtocol {
    var feedCoordinatorComponent: FeedCoordinatorComponentProtocol { FeedCoordinatorComponent(parent: self) }
}
