//
//  PhotoDTO.swift
//  TestTask
//
//  Created by Кирилл Володин on 09.11.2021.
//

import Foundation

struct PhotoDTO: Decodable {
    let id: String
    let title: String
    let urlSquare: String
    let urlMedium: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case urlSquare = "url_sq"
        case urlMedium = "url_m"
    }
}
