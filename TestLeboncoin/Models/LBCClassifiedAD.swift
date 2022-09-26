//
//  LBCClassifiedAD.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

struct LBCClassifiedAD: Decodable {
    let id: Int
    let title: String
    let categoryId: Int
    let creationDate: Date
    let description: String
    let imagesUrl: ImagesUrl
    let isUrgent: Bool
    let price: Float
}

extension LBCClassifiedAD: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LBCClassifiedAD, rhs: LBCClassifiedAD) -> Bool {
        lhs.id == rhs.id
    }
}
