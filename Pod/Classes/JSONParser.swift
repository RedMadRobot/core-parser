//
//  JSONParser.swift
//  Parser
//
//  Created by  Anton Poderechin on 31/01/16.
//  Copyright © 2016 BrosJam. All rights reserved.
//

import Foundation


/**
 Реализация JSON парсера.
 */
open class JSONParser<Model>: Parser<Model> {
    
    // MARK: - Абстрактные методы
    
    /* abstract */ open func parseObject(_ data: JSON) -> Model?
    {
        preconditionFailure("Необходимо переопределить метод Parser.parseObject()")
    }
    
    
    // MARK: - Конструктор
    
    override public init() {}
    
    
    // MARK: - Parser
    
    open override func parse(_ data: Any) -> [Model]
    {
        var objects:[Model] = []
        if let dictionary = data as? [String : AnyObject] {
            if let object = parseObject(JSON(dictionary)) {
                objects.append(object)
            }
            
            for (_, keyData) in dictionary {
                objects.append(contentsOf: parse(keyData))
            }
        } else if let array = data as? [AnyObject] {
            for itemData in array {
                objects.append(contentsOf: parse(itemData))
            }
        }
        
        return objects
    }
}


/**
 Экстеншн позволяет обращаться ко вложенным объектам.
 Например: json["key1"]["key2"]["key3"]
 */
public extension Optional where Wrapped: JSON {
    open subscript(_ key: String) -> JSON? {
        get {
            guard let json = self else { return nil }
            guard let dictionary = json.value as? [String: AnyObject] else { return nil }
            guard let result =  dictionary[key] else { return nil }
            return JSON(result)
        }
    }
}

/**
 Вспомогательный класс для преобразования из json.
 */
open class JSON {
    
    let value: Any
    
    
    // MARK: - Конструктор
    
    public init(_ value: Any)
    {
        self.value = value
    }
    
    
    // MARK: - Операторы
    
    open subscript(_ key: String) -> JSON? {
        get {
            guard let dictionary = value as? [String: AnyObject] else { return nil }
            guard let result =  dictionary[key] else { return nil }
            return JSON(result)
        }
    }
    
    
    // MARK: - Примитивные типы
    
    open var int: Int? { return asInt() }
    open var float: Float? { return asFloat() }
    open var double: Double? { return asDouble() }
    open var bool: Bool? { return asBool() }
    open var string: String? { return asString() }
    
    
    // MARK: - Helper
    
    open func raw() -> Any
    {
        return value
    }
    
    open func asInt() -> Int?
    {
        switch value {
        case let number as NSNumber:
            return number.intValue
        case let string as String:
            return Int(string)
        default:
            return nil
        }
    }
    
    open func asFloat() -> Float?
    {
        switch value {
        case let number as NSNumber:
            return number.floatValue
        case let string as String:
            return Float(string)
        default:
            return nil
        }
    }
    
    open func asDouble() -> Double?
    {
        switch value {
        case let number as NSNumber:
            return number.doubleValue
        case let string as String:
            return Double(string)
        default:
            return nil
        }
    }
    
    open func asBool() -> Bool?
    {
        switch value {
        case let number as NSNumber:
            return number.boolValue
        default:
            return nil
        }
    }
    
    open func asString() -> String?
    {
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
