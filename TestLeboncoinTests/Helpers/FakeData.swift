//
//  FakeData.swift
//  TestLeboncoinTests
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import Foundation

class FakeData {
    let data: Data?
    
    init(file: String, fileExt: String) {
        let bundle = Bundle(for: FakeData.self)
        guard let url = bundle.url(forResource: file, withExtension: fileExt) else {
            fatalError("\(file).\(fileExt) not found")
        }
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("\(file).\(fileExt) could not be loaded")
        }
    }
}
