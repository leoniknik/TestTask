//
//  ApplicationCoordinator.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

protocol ApplicationCoordinatorProtocol: CoordinatorProtocol {
    
}

final class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let scope: Any
    private let interactor: ApplicationCoordinatorInteractorProtocol
    private let feedCoordinatorAssembly: FeedCoordinatorAssemblyProtocol
    
    init(
        scope: Any,
        interactor: ApplicationCoordinatorInteractorProtocol,
        window: UIWindow,
        feedCoordinatorAssembly: FeedCoordinatorAssemblyProtocol
    ) {
        self.window = window
        self.scope = scope
        self.interactor = interactor
        self.feedCoordinatorAssembly = feedCoordinatorAssembly
    }
    
    override func start() {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showFeed(navigationController: navigationController)
    }
    
    private func showFeed(navigationController: UINavigationController) {
        var finishHandler: (() -> ())?
        let coordinator = feedCoordinatorAssembly.assemble(navigationController: navigationController) {
            finishHandler?()
        }
        finishHandler = { [weak self, weak coordinator] in
            guard let coordinator = coordinator else { return }
            self?.removeCoordinator(type: type(of: coordinator))
        }
        addCoordinator(coordinator)
        coordinator.start()
    }
}

extension ApplicationCoordinator: ApplicationCoordinatorProtocol {
    
}

extension ApplicationCoordinator: ApplicationCoordinatorInteractorDelegate {
    
}
