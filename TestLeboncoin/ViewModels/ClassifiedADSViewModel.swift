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
    var classifiedADS: [ClassifiedAD] = []
    var currentClassifiedADS = CurrentValueSubject<[ClassifiedAD], Never>([])
    var category: Int? {
        didSet {
            currentClassifiedADS.value = classifiedADS.filter({ classifiedADS in
                classifiedADS.categoryId == category
            })
        }
    }
    
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
        lbcApiService.getClassifiedADS { [weak self] classifiedADS in
            if let classifiedADSSorted = self?.sortClassifiedADS(classifiedADS) {
                self?.classifiedADS = classifiedADSSorted
                self?.currentClassifiedADS.value = self?.classifiedADS ?? []
            }
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
    
    func sortClassifiedADS(_ classifiedADS: [ClassifiedAD]) -> [ClassifiedAD] {
        let dateSorted = classifiedADS.sorted { $0.creationDate > $1.creationDate }
        let classifiedADSSorted = dateSorted.sorted { $0.isUrgent && !$1.isUrgent }
        
        return classifiedADSSorted
    }
    
    func categoryName(id: Int) -> String {
        if let category = categories.value.first(where: { $0.id == id } ) {
            return category.name
        }
        
        return ""
    }
}
