//
//  PhotoFeedPageDTO.swift
//  TestTask
//
//  Created by Кирилл Володин on 09.11.2021.
//

import Foundation

struct PhotoFeedPageDTO: Decodable {
    let page: Int
    let photos: [PhotoDTO]
    
    enum CodingKeys: String, CodingKey {
        case page
        case photos = "photo"
    }
}
