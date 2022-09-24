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
    var classifiedADS: [ClassifiedAD] = []    // = CurrentValueSubject<[ClassifiedAD], Never>([])
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
        //print(classifiedADS)
//                print("Avant")
//                for item in classifiedADS {
//                    print("\(item.creationDate) \(item.isUrgent)")
//                }
        let dateSorted = classifiedADS.sorted { $0.creationDate > $1.creationDate }   // && ($0.isUrgent && !$1.isUrgent) }
        let classifiedADSSorted = dateSorted.sorted { $0.isUrgent && !$1.isUrgent }
        
        print("Après")
        for item in classifiedADSSorted {
            print("\(item.creationDate) \(item.isUrgent)")
        }
        
        return classifiedADSSorted
    }
    
    func findCategory(id: Int) -> String {
        if let category = categories.value.first(where: { $0.id == id } ) {
            return category.name
        }
        
        return ""
    }
    
    func getCategory(category: Int) {
        
    }
}
