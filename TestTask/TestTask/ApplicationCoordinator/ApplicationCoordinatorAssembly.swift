//
//  ApplicationCoordinatorAssembly.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

protocol ApplicationCoordinatorAssemblyProtocol {
    func assemble(window: UIWindow) -> ApplicationCoordinatorProtocol
}

final class ApplicationCoordinatorAssembly {
}

extension ApplicationCoordinatorAssembly: ApplicationCoordinatorAssemblyProtocol {
    func assemble(window: UIWindow) -> ApplicationCoordinatorProtocol {
        let component = ApplicationComponent()
        let interactor = ApplicationCoordinatorInteractor()
        
        let feedCoordinatorAssembly = FeedCoordinatorAssembly(component: component.feedCoordinatorComponent)
        let coordinator = ApplicationCoordinator(
            scope: component,
            interactor: interactor,
            window: window,
            feedCoordinatorAssembly: feedCoordinatorAssembly
        )
        interactor.delegate = coordinator
        return coordinator
    }
}
