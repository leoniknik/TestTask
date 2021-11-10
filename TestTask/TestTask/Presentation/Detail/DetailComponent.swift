//
//  DetailComponent.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import NeedleFoundation

protocol DetailDependency: Dependency {
}

protocol DetailComponentProtocol {
}

final class DetailComponent: Component<DetailDependency> {
    
}
 
extension DetailComponent: DetailComponentProtocol {
}
