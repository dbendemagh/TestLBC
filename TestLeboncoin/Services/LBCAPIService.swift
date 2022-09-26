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
    
    let categoriesUrl: String = { LBCURL.basePath + LBCURL.categories }()
    let classifiedADSUrl: String = { LBCURL.basePath + LBCURL.classifiedADS }()
    
    func getCategories(completion: @escaping ([LBCCategory]) -> Void) {
        apiService.getJson(urlString: categoriesUrl, objectType: [LBCCategory].self) { result in
            switch result {
            case .success(let categories):
                completion(categories)
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getClassifiedADS(completion: @escaping ([LBCClassifiedAD]) -> Void) {
        apiService.getJson(urlString: classifiedADSUrl, objectType: [LBCClassifiedAD].self) { result in
            switch result {
            case .success(let classifiedADS):
                completion(classifiedADS)
                return
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
