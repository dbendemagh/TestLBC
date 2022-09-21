//
//  APIServiceTests.swift
//  TestLeboncoinTests
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import XCTest
@testable import TestLeboncoin

class APIServiceTests: XCTestCase {
    func testFetchData_Success() {
        let fakeData = FakeData(file: JsonFile.categories, fileExt: "json")
        let urlSessionFake = URLSessionFake(data: fakeData.data,
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        if let url = URL(string: "www.test.com") {
            apiService.get(url: url, objectType: [LBCCategory].self) { result in
                guard case .success(let categories) = result else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(categories.count, 11)
            }
        }
    }
    
    func testFetchData_Failure_NetworkError() {
        let urlSessionFake = URLSessionFake(data: nil,
                                            response: FakeNetworkResponse.httpError,
                                            error: LBCError.networkError)
        let apiService = APIService(urlSession: urlSessionFake)
        
        if let url = URL(string: "www.test.com") {
            apiService.get(url: url, objectType: [LBCCategory].self) { result in
                guard case .failure(let error) = result else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(error, LBCError.networkError)
                print("Erreur : \(error)")
            }
        }
    }
    
    func testFetchData_Failure_HttpError() {
        let urlSessionFake = URLSessionFake(data: nil,
                                            response: FakeNetworkResponse.httpError,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        if let url = URL(string: "www.test.com") {
            apiService.get(url: url, objectType: [LBCCategory].self) { result in
                guard case .failure(let error) = result else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(error, LBCError.httpError)
            }
        }
    }
    
    func testFetchData_Failure_NoData() {
        let urlSessionFake = URLSessionFake(data: nil,
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        if let url = URL(string: "www.test.com") {
            apiService.get(url: url, objectType: [LBCCategory].self) { result in
                guard case .failure(let error) = result else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(error, LBCError.noData)
            }
        }
    }
    
    func testFetchData_Failure_InvalidData() {
        let urlSessionFake = URLSessionFake(data: FakeNetworkResponse.incorrectData,
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        if let url = URL(string: "www.test.com") {
            apiService.get(url: url, objectType: [LBCCategory].self) { result in
                guard case .failure(let error) = result else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(error, LBCError.invalidData)
            }
        }
    }
}
