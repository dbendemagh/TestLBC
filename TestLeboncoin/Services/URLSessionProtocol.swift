//
//  URLSessionProtocol.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

protocol URLSessionProtocol {
    func request(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
