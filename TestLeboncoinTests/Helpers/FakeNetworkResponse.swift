//
//  FakeNetworkResponse.swift
//  TestLeboncoinTests
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

class FakeNetworkResponse {
    static let httpOK = HTTPURLResponse(url: URL(string: "https://www.test.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let httpError = HTTPURLResponse(url: URL(string: "https://www.test.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    static let incorrectData = "erreur".data(using: .utf8)
}
