//
//  JSONParser.swift
//  Parser
//
//  Created by Anton Poderechin on 31/01/16.
//  Copyright © 2016 RedMadRobot. All rights reserved.
//

import Foundation


/**
    JSON parser implementation.
 */
open class JSONParser<Model>: Parser<Model> {
    
    fileprivate let logLevel: JSONParserLogLevel
    
    // MARK: - Abstract methods
    
    
    /* abstract */ open func parseObject(_ data: JSON) -> Model? {
        preconditionFailure("You need to override JSONParser.parseObject()")
    }
    
    
    /* abstract */ open class func modelFields() -> Fields {
        preconditionFailure("You need to override JSONParser.modelFields()")
    }
    
    
    // MARK: - Init
    
    override public init() {
        self.logLevel = JSONParserLogLevel.silent
        super.init()
    }
    
    
    public init(logLevel: JSONParserLogLevel) {
        self.logLevel = logLevel
        super.init()
    }
    
    
    // MARK: - Parser
    
    open func parse(json data: JSON) -> [Model] {
        return parse(data.raw())
    }
    
    
    open override func parse(_ data: Any) -> [Model] {
        var objects:[Model] = []
        if let dictionary = data as? [String : AnyObject] {
            if let object = parseObject(JSON(dictionary)) {
                objects.append(object)
            } else {
                for (_, keyData) in dictionary {
                    objects.append(contentsOf: parse(keyData))
                }
            }
        } else if let array = data as? [AnyObject] {
            for itemData in array {
                objects.append(contentsOf: parse(itemData))
            }
        }
        
        return objects
    }
    
    
    open func printAbsentFields(in data: JSON) {
        guard
            !loggerIsSilent(),
            let dataMap: [String: AnyObject] = data.asDictionary()
        else {
            return
        }
        
        let expectedFields: Fields = type(of: self).modelFields()
        let actualFields: Set<String> = Set(dataMap.keys)
        
        if actualFields.isDisjoint(with: expectedFields.mandatory) {
            return
        } else {
            let absentMandatoryFields: Set<String> = self.absentFields(
                expectedFields: expectedFields.mandatory,
                data: dataMap)
            let absentOptionalFields:  Set<String> = self.absentFields(
                expectedFields: expectedFields.optional,
                data: dataMap)
            
            if self.logLevel.rawValue >= JSONParserLogLevel.logMandatoryFields.rawValue {
                self.printFields(
                    absentMandatoryFields,
                    headMessage: "⛔️\(Model.self) MISSING MANDATORY FIELDS:",
                    symbol: "– ")
                if self.logLevel.rawValue >= JSONParserLogLevel.logAllFields.rawValue {
                    self.printFields(
                        absentOptionalFields,
                        headMessage: "⚠️\(Model.self) MISSING OPTIONAL FIELDS:",
                        symbol: "– ")
                }
            }
        }
    }
    
}


private extension JSONParser {
    
    func loggerIsSilent() -> Bool {
        return self.logLevel.rawValue <= JSONParserLogLevel.silent.rawValue
    }
    
    
    func absentFields(expectedFields: Set<String>, data: [String: AnyObject]) -> Set<String> {
        return expectedFields.subtracting(Set(data.keys))
    }
    
    
    func printFields(_ fields: Set<String>, headMessage: String, symbol: String) {
        if fields.isEmpty {
            return
        }
        print(headMessage)
        for field in fields {
            print(symbol + field)
        }
    }
    
}


/**
 Helper for nested objects
 Example: json["key1"]["key2"]["key3"]
 */
public extension Optional where Wrapped: JSON {
    
    public subscript(_ key: String) -> JSON? {
        guard let json = self else { return nil }
        guard let dictionary = json.value as? [String: AnyObject] else { return nil }
        guard let result =  dictionary[key] else { return nil }
        return JSON(result)
    }
    
}

/**
    Helper class for transform from json.
 */
open class JSON {
    
    let value: Any
    
    
    // MARK: - Init
    
    public init(_ value: Any) {
        self.value = value
    }
    
    
    // MARK: - Операторы
    
    open subscript(_ key: String) -> JSON? {
        guard let dictionary = value as? [String: AnyObject] else { return nil }
        guard let result =  dictionary[key] else { return nil }
        return JSON(result)
    }
    
    
    // MARK: - Primitive types
    
    open var int: Int? { return asInt() }
    open var float: Float? { return asFloat() }
    open var double: Double? { return asDouble() }
    open var bool: Bool? { return asBool() }
    open var string: String? { return asString() }
    open var dictionary: [String: AnyObject]? { return asDictionary() }
    open var array: [Any]? { return asArray() }
    
    
    // MARK: - Helper
    
    open func raw() -> Any {
        return value
    }
    
    
    open func asInt() -> Int? {
        switch value {
        case let number as NSNumber:
            return number.intValue
        case let string as String:
            return Int(string)
        default:
            return nil
        }
    }
    
    
    open func asFloat() -> Float? {
        switch value {
        case let number as NSNumber:
            return number.floatValue
        case let string as String:
            return Float(string)
        default:
            return nil
        }
    }
    
    
    open func asDouble() -> Double? {
        switch value {
        case let number as NSNumber:
            return number.doubleValue
        case let string as String:
            return Double(string)
        default:
            return nil
        }
    }
    
    
    open func asBool() -> Bool? {
        switch value {
        case let number as NSNumber:
            return number.boolValue
        default:
            return nil
        }
    }
    
    
    open func asString() -> String? {
        switch value {
        case let string as String:
            return string
        case let number as NSNumber:
            return number.stringValue
        default:
            return nil
        }
    }
    
    
    open func asDictionary() -> [String: AnyObject]? {
        return value as? [String: AnyObject]
    }
    
    
    open func asArray() -> [Any]? {
        return value as? [Any]
    }
    
}

/**
    Structure for mandatory and optional fields of model object.
 */
public struct Fields {
    let mandatory: Set<String>
    let optional:  Set<String>
    public init(mandatory: Set<String>, optional: Set<String>) {
        self.mandatory = mandatory
        self.optional  = optional
    }
}


/**
    Log levels.
 */
public enum JSONParserLogLevel: Int {
    case silent             = 0
    case logMandatoryFields = 1
    case logAllFields       = 2
}
