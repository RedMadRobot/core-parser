//
//  CoreParser_ExampleTests.swift
//  CoreParser_ExampleTests
//
//  Created by Ivan Vavilov on 20/11/2017.
//  Copyright © 2017 RedMadRobot. All rights reserved.
//

import XCTest
@testable import CoreParser_Example


final class CoreParser_ExampleTests: XCTestCase {
    
    private var jsonData: Data!
    private let parser = AccountParser(logLevel: .logMandatoryFields)
    
    
    override func setUp() {
        super.setUp()
        
        let path = Bundle(for: CoreParser_ExampleTests.self).path(forResource: "data", ofType: "json")!
        jsonData = try! Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    
    func testExample() {
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let objects = parser.parse(json)
            // only one object has all obligatory parameters
            XCTAssertEqual(objects.count, 1)
        } catch let error as NSError {
            XCTFail("\(error.localizedDescription)")
        }
    }
    
}
