//
//  FeedCoordinatorAssembly.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

protocol FeedCoordinatorAssemblyProtocol {
    func assemble(
        navigationController: UINavigationController,
        finishHandler: @escaping () -> ()
    ) -> FeedCoordinatorProtocol
}

final class FeedCoordinatorAssembly {
    private let component: FeedCoordinatorComponentProtocol
    
    init(component: FeedCoordinatorComponentProtocol) {
        self.component = component
    }
}

extension FeedCoordinatorAssembly: FeedCoordinatorAssemblyProtocol {
    func assemble(
        navigationController: UINavigationController,
        finishHandler: @escaping () -> ()
    ) -> FeedCoordinatorProtocol {
        let feedAssembly = FeedAssembly(component: component.feedComponent)
        
        let interactor = FeedCoordinatorInteractor()
        let coordinator = FeedCoordinator(
            navigationController: navigationController,
            interactor: interactor,
            feedAssembly: feedAssembly,
            finishHandler: finishHandler
        )
        interactor.delegate = coordinator
        return coordinator
    }
}

