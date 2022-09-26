//
//  APIService.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import UIKit

class APIService {
    var urlSession: URLSessionProtocol
    var task: URLSessionDataTask?
    
    let imageCache = NSCache<NSString, UIImage>()
    
    init(urlSession: URLSessionProtocol = LBCURLSession()) {
        self.urlSession = urlSession
    }
    
    func getJson<T>(urlString: String, objectType: T.Type, completion: @escaping (Result<T, LBCError>) -> Void) where T : Decodable {
        getData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                let resultJson = self.jsonDecode(data: data, objectType: objectType)
                switch resultJson {
                case .success(let objects):
                    completion(.success(objects))
                    return
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
    
    func getImage(urlString: String, completion: @escaping (Result<UIImage, LBCError>) -> Void) {
        let imageKey = NSString(string: urlString)
        if let image = imageCache.object(forKey: imageKey) {
            completion(.success(image))
            return
        }
        
        getData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: imageKey)
                    completion(.success(image))
                    return
                } else {
                    completion(.failure(LBCError.noData))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
    
    private func getData(urlString: String, completion: @escaping (Result<Data, LBCError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(LBCError.invalidURL))
            return
        }
        
        urlSession.request(with: url, completion: { data, response, error in
            DispatchQueue.main.async {
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

                completion(.success(data))
                return
            }
        })
    }
    
    private func jsonDecode<T>(data: Data, objectType: T.Type) -> Result<T, LBCError> where T : Decodable {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            let objects = try decoder.decode(T.self, from: data)
            print("décodage ok")
            return .success(objects)
        }
        catch {
            print(error)
            return .failure(LBCError.invalidData)
        }
    }
}
