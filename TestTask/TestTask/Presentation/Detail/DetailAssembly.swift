//
//  DetailAssembly.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import Foundation

protocol DetailAssemblyProtocol {
    func assemble(photo: Photo, output: DetailModuleOutput) -> Module<DetailModuleInput>
}

final class DetailAssembly {
    // bip: скоупы
    private let component: DetailComponentProtocol
    
    init(component: DetailComponentProtocol) {
        self.component = component
    }
}

extension DetailAssembly: DetailAssemblyProtocol {
    func assemble(photo: Photo, output: DetailModuleOutput) -> Module<DetailModuleInput> {
        let presenter = DetailPresenter()
        let interactor = DetailInteractor(output: output, presenter: presenter, photo: photo)
        let viewController = DetailViewController(interactor: interactor)
        presenter.view = viewController
        return Module(input: interactor as DetailModuleInput, view: viewController)
    }
}
