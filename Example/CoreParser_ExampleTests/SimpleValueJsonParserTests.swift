//
//  SimpleValueJsonParserTests.swift
//  CoreParser_ExampleTests
//
//  Created by Anton Glezman on 24.08.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import CoreParser


final class SimpleValueJsonParserTests: XCTestCase {
    
    func getJsonFromString(_ value: String) -> Any {
        let data = value.data(using: .utf8)!
        return try! JSONSerialization.jsonObject(with: data, options: [])
    }
    
    func testParseInt() {
        let jsonString = "{\"data\":{\"value\": 123}}"
        let json = getJsonFromString(jsonString)
        
        let value = SimpleValueJsonParser<Int>().parse(json).first
        
        XCTAssertEqual(value, 123)
    }
    
    func testParseInt_otherJson() {
        let jsonString = "{\"some_key\": 111}"
        let json = getJsonFromString(jsonString)
        
        let value = SimpleValueJsonParser<Int>().parse(json).first
        
        XCTAssertEqual(value, 111)
    }
    
    func testParseFloat() {
        let jsonString = "{\"data\":{\"value\": 1.23}}"
        let json = getJsonFromString(jsonString)
        
        let value = SimpleValueJsonParser<Float>().parse(json).first
        
        XCTAssertEqual(value, 1.23)
    }
    
    func testParseDouble() {
        let jsonString = "{\"data\":{\"value\": 3.1415926}}"
        let json = getJsonFromString(jsonString)
        
        let value = SimpleValueJsonParser<Double>().parse(json).first
        
        XCTAssertEqual(value, 3.1415926)
    }
    
    func testParseBool_true() {
        let jsonString = "{\"data\":{\"value\": true}}"
        let json = getJsonFromString(jsonString)
        
        let value = SimpleValueJsonParser<Bool>().parse(json).first
        
        XCTAssertEqual(value, true)
    }
    
    func testParseBool_false() {
        let jsonString = "{\"data\":{\"value\": false}}"
        let json = getJsonFromString(jsonString)
        
        let value = SimpleValueJsonParser<Bool>().parse(json).first
        
        XCTAssertEqual(value, false)
    }
    
    func testParseString() {
        let jsonString = "{\"data\":{\"value\": \"some text\"}}"
        let json = getJsonFromString(jsonString)
        
        let value = SimpleValueJsonParser<String>().parse(json).first
        
        XCTAssertEqual(value, "some text")
    }
}
