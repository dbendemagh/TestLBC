//
//  LBCApiServiceTests.swift
//  TestLeboncoinTests
//
//  Created by Daniel BENDEMAGH on 26/09/2022.
//

import XCTest
@testable import TestLeboncoin

class LBCApiServiceTests: XCTestCase {

    func testCategoriesUrl() {
        let lbcApiService = LBCApiService()
        XCTAssertEqual(lbcApiService.categoriesUrl, "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json")
    }
    
    func testClassifiedADSUrl() {
        let lbcApiService = LBCApiService()
        XCTAssertEqual(lbcApiService.classifiedADSUrl, "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")
    }
    
    func testGetCategories() {
        let fakeCategories = FakeData(file: JsonFile.categories, fileExt: "json")
        let urlSessionFake = URLSessionFake(lbcData: LbcData(categories: fakeCategories.data, classifiedADS: nil, image: nil),
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        let lbcApiService = LBCApiService(apiService: apiService)
        let expectation = XCTestExpectation(description: "Get categories")
        
        lbcApiService.getCategories { categories in
            XCTAssertEqual(categories.count, 11)
            XCTAssertEqual(categories[0].id, 1)
            XCTAssertEqual(categories[0].name, "Véhicule")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetClassifiedADS() {
        let fakeClassifiedADS = FakeData(file: JsonFile.classifiedADs, fileExt: "json")
        let urlSessionFake = URLSessionFake(lbcData: LbcData(categories: nil, classifiedADS: fakeClassifiedADS.data, image: nil),
                                            response: FakeNetworkResponse.httpOK,
                                            error: nil)
        let apiService = APIService(urlSession: urlSessionFake)
        let lbcApiService = LBCApiService(apiService: apiService)
        let expectation = XCTestExpectation(description: "Get classified ADS")
        
        lbcApiService.getClassifiedADS { classifiedADS in
            XCTAssertEqual(classifiedADS.count, 300)
            XCTAssertEqual(classifiedADS[0].id, 1461267313)
            XCTAssertEqual(classifiedADS[0].title, "Statue homme noir assis en plâtre polychrome")
            XCTAssertEqual(classifiedADS[0].categoryId, 4)
            XCTAssertEqual(classifiedADS[0].isUrgent, false)
            XCTAssertEqual(classifiedADS[0].price, 140)
            XCTAssertEqual(classifiedADS[0].imagesUrl.thumb, "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
