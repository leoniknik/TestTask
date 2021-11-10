//
//  FeedCoordinatorInteractor.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import Foundation

protocol FeedCoordinatorInteractorDelegate: AnyObject {
    
}

protocol FeedCoordinatorInteractorProtocol {
    
}

final class FeedCoordinatorInteractor {
    weak var delegate: FeedCoordinatorInteractorDelegate?
}

extension FeedCoordinatorInteractor: FeedCoordinatorInteractorProtocol {
    
}
