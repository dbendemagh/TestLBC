//
//  LBCClassifiedAD.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

struct ClassifiedAD: Decodable {
    let id: Int
    let name: String?
    let categoryId: Int
    let creationDate: Date
    let description: String
    let imagesUrl: ImagesUrl
    let isUrgent: Bool
    let price: Float
}
