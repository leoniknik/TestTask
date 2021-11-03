//
//  ApplicationCoordinatorInteractor.swift
//  TestTask
//
//  Created by Кирилл Володин on 01.11.2021.
//

import Foundation

protocol ApplicationCoordinatorInteractorDelegate: AnyObject {
    
}

protocol ApplicationCoordinatorInteractorProtocol {
    
}

final class ApplicationCoordinatorInteractor {
    weak var delegate: ApplicationCoordinatorInteractorDelegate?
}

extension ApplicationCoordinatorInteractor: ApplicationCoordinatorInteractorProtocol {
    
}
