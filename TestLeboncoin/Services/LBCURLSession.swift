//
//  LBCURLSession.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

class LBCURLSession: URLSessionProtocol {
    let urlSession = URLSession(configuration: .default)
    
    func request(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = urlSession.dataTask( with: url, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        task.resume()
    }
}
