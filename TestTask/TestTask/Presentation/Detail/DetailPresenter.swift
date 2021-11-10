//
//  DetailPresenter.swift
//  TestTask
//
//  Created by Кирилл Володин on 10.11.2021.
//

import Foundation

protocol DetailPresentationLogic {
    func present(photo: Photo)
    func presentSavingToGallery()
}

final class DetailPresenter {
    weak var view: DetailDisplayLogic?
}

extension DetailPresenter: DetailPresentationLogic {
    func present(photo: Photo) {
        guard let url = URL(string: photo.urlMedium) else { return }
        view?.display(viewModel: .init(url: url))
    }
    
    func presentSavingToGallery() {
        view?.displaySavingToGallery()
    }
}
