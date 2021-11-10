//
//  FeedAssembly.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import Foundation

protocol FeedAssemblyProtocol {
    func assemble(output: FeedModuleOutput) -> Module<FeedModuleInput>
}

final class FeedAssembly {
    private let component: FeedComponentProtocol
    
    init(component: FeedComponentProtocol) {
        self.component = component
    }
}

extension FeedAssembly: FeedAssemblyProtocol {
    func assemble(output: FeedModuleOutput) -> Module<FeedModuleInput> {
        let presenter = FeedPresenter()
        let interactor = FeedInteractor(
            output: output,
            presenter: presenter,
            feedService: component.feedService,
            worker: FeedDebounceWorker(debouncer: Debouncer(delay: 1.5))
        )
        let viewController = FeedViewController(interactor: interactor)
        presenter.view = viewController
        return Module(input: interactor as FeedModuleInput, view: viewController)
    }
}
