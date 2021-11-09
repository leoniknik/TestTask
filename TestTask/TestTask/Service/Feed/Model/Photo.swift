//
//  Photo.swift
//  TestTask
//
//  Created by Кирилл Володин on 09.11.2021.
//

import Foundation

struct Photo {
    let id: String
    let title: String
    let urlSquare: String
    let urlMedium: String
    
    init(dto: PhotoDTO) {
        self.id = dto.id
        self.title = dto.title
        self.urlMedium = dto.urlMedium
        self.urlSquare = dto.urlSquare
    }
}
