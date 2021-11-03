//
//  FeedInteractor.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import Foundation

protocol FeedBusinessLogic {
    
}

protocol FeedModuleInput {
}

protocol FeedModuleOutput: AnyObject {
}


final class FeedInteractor {
    private weak var output: FeedModuleOutput?
    private let presenter: FeedPresentationLogic
    
    init(output: FeedModuleOutput, presenter: FeedPresentationLogic) {
        self.output = output
        self.presenter = presenter
    }
}

extension FeedInteractor: FeedBusinessLogic {
    
}

extension FeedInteractor: FeedModuleInput {
    
}
