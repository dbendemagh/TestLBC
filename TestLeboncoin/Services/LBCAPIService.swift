//
//  LBCAPIService.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

class LBCApiService {
    var apiService = APIService()
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func createClassifiedADSURL() -> URL? {
        let urlString = LBCURL.basePath + LBCURL.classifiedADS
        return URL(string: urlString)
    }
    
    func createCategoriesURL() -> URL? {
        let urlString = LBCURL.basePath + LBCURL.categories
        return URL(string: urlString)
    }
    
    func getCategories(completion: @escaping ([LBCCategory]) -> Void) {
        guard let categoriesURL = createCategoriesURL() else {
            return
        }
        
        apiService.get(url: categoriesURL, objectType: [LBCCategory].self) { result in
            switch result {
            case .success(let categories):
                print(categories)
                completion(categories)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getClassifiedADS(completion: @escaping ([ClassifiedAD]) -> Void) {
        guard let classifiedURL = createClassifiedADSURL() else {
            return
        }
        
        apiService.get(url: classifiedURL, objectType: [ClassifiedAD].self) { result in
            switch result {
            case .success(let classifiedADS):
                print(classifiedADS)
                completion(classifiedADS)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
