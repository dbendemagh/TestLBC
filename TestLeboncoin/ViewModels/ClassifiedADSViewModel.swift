//
//  ClassifiedADSViewModel.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation
import Combine

class ClassifiedADSViewModel {
    var categories = CurrentValueSubject<[LBCCategory], Never>([])
    var classifiedADS = CurrentValueSubject<[ClassifiedAD], Never>([])
    
    let lbcApiService = LBCApiService()
    
    init() {
        fetchCategories()
        fetchClassifiedADS()
    }
    
    private func fetchCategories() {
        lbcApiService.getCategories { categories in
            self.categories.value = categories
        }
    }
    
    private func fetchClassifiedADS() {
        lbcApiService.getClassifiedADS { classifiedADS in
            self.classifiedADS.value = classifiedADS
        }
    }
}
