//
//  APIService.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

class APIService {
    var urlSession: URLSessionProtocol
    var task: URLSessionDataTask?
    
    init(urlSession: URLSessionProtocol = LBCURLSession()) {
        self.urlSession = urlSession
    }
    
    func get<T>(url: URL, objectType: T.Type, completion: @escaping (Result<T, LBCError>) -> Void) where T : Decodable {
        
        urlSession.request(with: url, completion: { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(LBCError.networkError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(LBCError.httpError))
                return
            }

            guard let data = data else {
                completion(.failure(LBCError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let objects = try decoder.decode(objectType.self, from: data)
                completion(.success(objects))
            }
            catch {
                print(error)
                completion(.failure(LBCError.invalidData))
            }
        })
    }
}
