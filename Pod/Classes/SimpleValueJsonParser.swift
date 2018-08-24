//
//  SimpleValueJsonParser.swift
//  Parser
//
//  Created by Anton Glezman on 24.08.2018.
//  Copyright © 2018 RedMadRobot. All rights reserved.
//

import Foundation

/**
 JSON parser implementation.
 This class is intended for extracting primitive type values from json.
 Supported types: Int, Float, Double, String, Bool.
 Example: {"data":{"value": 123}}  ->  123
 */
open class SimpleValueJsonParser<Model: PrimitiveConvertible>: Parser<Model> {
    
    public override init() {
        super.init()
    }
    
    open override func parse(_ data: Any) -> [Model] {
        var objects:[Model] = []
        if let dictionary = data as? [String : AnyObject] {
            if let object = parseObject(dictionary.first?.value as Any) {
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
    
    open func parse(json data: JSON) -> [Model] {
        return parse(data.raw())
    }
    
    open func parseObject(_ data: Any) -> Model? {
        return Model.toNative(value: data) as? Model
    }
}

/**
 The protocol declares a method for convert Json value to native primitive type
 */
public protocol PrimitiveConvertible {
    static func toNative(value: Any) -> PrimitiveConvertible?
}


extension Int: PrimitiveConvertible {
    public static func toNative(value: Any) -> PrimitiveConvertible? {
        switch value {
        case let number as NSNumber:
            return number.intValue
        case let string as String:
            return Int(string)
        default:
            return nil
        }
    }
}

extension Float: PrimitiveConvertible {
    public static func toNative(value: Any) -> PrimitiveConvertible? {
        switch value {
        case let number as NSNumber:
            return number.floatValue
        case let string as String:
            return Float(string)
        default:
            return nil
        }
    }
}

extension Double: PrimitiveConvertible {
    public static func toNative(value: Any) -> PrimitiveConvertible? {
        switch value {
        case let number as NSNumber:
            return number.doubleValue
        case let string as String:
            return Double(string)
        default:
            return nil
        }
    }
}

extension Bool: PrimitiveConvertible {
    public static func toNative(value: Any) -> PrimitiveConvertible? {
        switch value {
        case let number as NSNumber:
            return number.boolValue
        default:
            return nil
        }
    }
}

extension String: PrimitiveConvertible {
    public static func toNative(value: Any) -> PrimitiveConvertible? {
        switch value {
        case let string as String:
            return string
        case let number as NSNumber:
            return number.stringValue
        default:
            return nil
        }
    }
}
