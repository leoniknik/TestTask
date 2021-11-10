//
//  DetailInteractor.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import UIKit

protocol DetailBusinessLogic {
    func viewDidLoad()
    func saveTapped()
}

protocol DetailModuleInput {
}

protocol DetailModuleOutput: AnyObject {
}


final class DetailInteractor {
    private weak var output: DetailModuleOutput?
    private let presenter: DetailPresentationLogic
    private let photo: Photo
    
    init(output: DetailModuleOutput, presenter: DetailPresentationLogic, photo: Photo) {
        self.output = output
        self.presenter = presenter
        self.photo = photo
    }
}

extension DetailInteractor: DetailBusinessLogic {
    func saveTapped() {
        presenter.presentSavingToGallery()
    }
    
    func viewDidLoad() {
        presenter.present(photo: photo)
    }
}

extension DetailInteractor: DetailModuleInput {
}
