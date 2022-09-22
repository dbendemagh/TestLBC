//
//  LBCCategory.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

struct LBCCategory: Decodable {
    let id: Int
    let name: String
}

extension LBCCategory: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: LBCCategory, rhs: LBCCategory) -> Bool {
        lhs.id == rhs.id
    }
}
