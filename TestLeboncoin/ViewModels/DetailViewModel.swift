//
//  DetailViewModel.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 25/09/2022.
//

import UIKit
import Combine

class DetailViewModel {
    let lbcApiService = LBCApiService()
    
    var imageView = CurrentValueSubject<UIImage?, Never>(nil)
    
    var classifiedAD: ClassifiedAD? = nil
    
    var priceString: String { classifiedAD?.price.floatToEuro() ?? "" }
    var dateCreationString: String { classifiedAD?.creationDate.dateToString() ?? "" }
    var categoryName: String = ""
    
    init(classifiedAD: ClassifiedAD? = nil) {
        if classifiedAD != nil {
            self.classifiedAD = classifiedAD
            fetchImage()
        }
    }
    
    func fetchImage() {
        guard let classifiedAD = classifiedAD else { return }
        
        guard let urlString = classifiedAD.imagesUrl.thumb else { return }
        lbcApiService.apiService.getImage (urlString: urlString) { result in
            switch result {
            case .success(let image):
                self.imageView.value = image
            case .failure:
                break
            }
        }
    }
}
