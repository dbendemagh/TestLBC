//
//  APIServiceTests.swift
//  TestLeboncoinTests
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import XCTest
@testable import TestLeboncoin

class APIServiceTests: XCTestCase {
    let urlString = LBCURL.basePath + LBCURL.categories
    let imageUrlString = "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/50b3d5870d57b3df834b43088171fef852997529.jpg"
    
    func testGetJson_Success() {
        let fakeCategories = FakeData(file: JsonFile.categories, fileExt: "json")
        let urlSessionFake = URLSessionFake(lbcData: LbcData(categories: fakeCategories.data, classifiedADS: nil, image: nil),
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        
        let expectation = XCTestExpectation(description: "Fetch categories")
        
        apiService.getJson(urlString: urlString, objectType: [LBCCategory].self) { result in
            guard case .success(let categories) = result else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(categories.count, 11)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetJson_Failure_NetworkError() {
        let urlSessionFake = URLSessionFake(lbcData: nil,
                                            response: FakeNetworkResponse.httpError,
                                            error: LBCError.networkError)
        let apiService = APIService(urlSession: urlSessionFake)
        
        let expectation = XCTestExpectation(description: "Fetch categories")
        
        apiService.getJson(urlString: urlString, objectType: [LBCCategory].self) { result in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, LBCError.networkError)
            print("Erreur : \(error)")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFGetJson_Failure_HttpError() {
        let urlSessionFake = URLSessionFake(lbcData: nil,
                                            response: FakeNetworkResponse.httpError,
                                            error: nil)
        
        let apiService = APIService(urlSession: urlSessionFake)
        let expectation = XCTestExpectation(description: "Fetch categories")
        
        apiService.getJson(urlString: urlString, objectType: [LBCCategory].self) { result in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, LBCError.httpError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetJson_Failure_NoData() {
        let urlSessionFake = URLSessionFake(lbcData: nil,
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        let expectation = XCTestExpectation(description: "Fetch categories")
        
        apiService.getJson(urlString: urlString, objectType: [LBCCategory].self) { result in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, LBCError.noData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetJson_Failure_InvalidData() {
        let urlSessionFake = URLSessionFake(lbcData: LbcData(categories: FakeNetworkResponse.incorrectData, classifiedADS: nil, image: nil),
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        let expectation = XCTestExpectation(description: "Fetch categories")
        
        apiService.getJson(urlString: urlString, objectType: [LBCCategory].self) { result in
            guard case .failure(let error) = result else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(error, LBCError.invalidData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetImage() {
        let fakeImage = FakeData(file: "Guitare", fileExt: "jpg")
        let urlSessionFake = URLSessionFake(lbcData: LbcData(categories: nil,
                                                             classifiedADS: nil,
                                                             image: fakeImage.data),
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        
        let expectation = XCTestExpectation(description: "Get image")
        
        apiService.getImage(urlString: imageUrlString) { result in
            guard case .success(let image) = result else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(image.size, UIImage(data: fakeImage.data!)?.size)
            let imageCache = apiService.imageCache.object(forKey: NSString(string: self.imageUrlString))
            XCTAssertNotNil(imageCache)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
