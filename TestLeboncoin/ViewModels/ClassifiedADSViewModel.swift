//
//  ClassifiedADSViewModel.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation
import Combine
import UIKit

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
    
    func fetchImage(urlString: String, cell: ClassifiedADCell) {
        lbcApiService.apiService.getImage (urlString: urlString) { result in
            switch result {
            case .success(let image):
                cell.setImage(result: .success(image))
            case .failure:
                break
            }
     
        }
    }
    
    func findCategory(id: Int) -> String {
        if let category = categories.value.first(where: { $0.id == id } ) {
            return category.name
        }
        
        return ""
    }
}
