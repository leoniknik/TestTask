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
    private let datailAssembly: DetailAssemblyProtocol
    private let interactor: FeedCoordinatorInteractorProtocol
    private let navigationController: UINavigationController
    private let finishHandler: () -> ()
    
    init(
        navigationController: UINavigationController,
        interactor: FeedCoordinatorInteractorProtocol,
        feedAssembly: FeedAssemblyProtocol,
        datailAssembly: DetailAssemblyProtocol,
        finishHandler: @escaping () -> ()
    ) {
        self.navigationController = navigationController
        self.interactor = interactor
        self.feedAssembly = feedAssembly
        self.datailAssembly = datailAssembly
        self.finishHandler = finishHandler
    }
    
    override func start() {
        showFeed()
    }
    
    private func showFeed() {
        let module = feedAssembly.assemble(output: self)
        navigationController.pushViewController(module.view, animated: false)
    }
    
    private func showDetail(photo: Photo) {
        let module = datailAssembly.assemble(photo: photo, output: self)
        navigationController.pushViewController(module.view, animated: true)
    }
}

extension FeedCoordinator: FeedCoordinatorProtocol {
    
}

extension FeedCoordinator: FeedCoordinatorInteractorDelegate {
    
}

extension FeedCoordinator: FeedModuleOutput {
    func didSelect(photo: Photo) {
        showDetail(photo: photo)
    }
}

extension FeedCoordinator: DetailModuleOutput {
}
