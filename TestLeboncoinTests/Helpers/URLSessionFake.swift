//
//  URLSessionFake.swift
//  TestLeboncoinTests
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation
@testable import TestLeboncoin
import UIKit

struct LbcData {
    let categories: Data?
    let classifiedADS: Data?
    let image: Data?
}

class URLSessionFake: URLSessionProtocol {
    let lbcData: LbcData?
    let response: URLResponse?
    let error: Error?
    
    init(lbcData: LbcData?, response: URLResponse?, error: Error?) {
        self.lbcData = lbcData
        self.response = response
        self.error = error
    }
    
    func request(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if url.absoluteString.contains("categories") {
            completion(lbcData?.categories, response, error)
            return
        } else if url.absoluteString.contains("listing") {
            completion(lbcData?.classifiedADS, response, error)
            return
        } else {
            completion(lbcData?.image, response, error)
            return
        }
    }
}
