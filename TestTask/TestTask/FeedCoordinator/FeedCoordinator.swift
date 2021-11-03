//
//  FeedCoordinator.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import UIKit

protocol FeedCoordinatorProtocol: CoordinatorProtocol {
    
}

final class FeedCoordinator: Coordinator {
    private let feedAssembly: FeedAssemblyProtocol
    private let interactor: FeedCoordinatorInteractorProtocol
    private let navigationController: UINavigationController
    private let finishHandler: () -> ()
    
    init(
        navigationController: UINavigationController,
        interactor: FeedCoordinatorInteractorProtocol,
        feedAssembly: FeedAssemblyProtocol,
        finishHandler: @escaping () -> ()
    ) {
        self.navigationController = navigationController
        self.interactor = interactor
        self.feedAssembly = feedAssembly
        self.finishHandler = finishHandler
    }
    
    override func start() {
        let module = feedAssembly.assemble(output: self)
        navigationController.pushViewController(module.view, animated: false)
    }
}

extension FeedCoordinator: FeedCoordinatorProtocol {
    
}

extension FeedCoordinator: FeedCoordinatorInteractorDelegate {
    
}

extension FeedCoordinator: FeedModuleOutput {
    
}
