//
//  URLSessionFake.swift
//  TestLeboncoinTests
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation
@testable import TestLeboncoin

class URLSessionFake: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func request(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completion(data, response, error)
    }
}
