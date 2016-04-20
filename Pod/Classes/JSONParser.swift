//
//  JSONParser.swift
//  Parser
//
//  Created by  Anton Poderechin on 31/01/16.
//  Copyright © 2016 BrosJam. All rights reserved.
//

import Foundation


/**
 Реализация парсера на SwiftyJSON.
 */
public class JSONParser<Model>: Parser<Model> {
    
    var fulfiller: Fulfiller<Model>?

    // MARK: Public
    // MARK: Abstract
    
    /* abstract */ public func parseObject(data: [String : JSON]) -> Model?
    {
        preconditionFailure("Необходимо переопределить метод Parser.parseObject")
    }
    
    // MARK: Constructor
    
    public convenience override init()
    {
        self.init(fulfiller: nil)
    }
    
    public init(fulfiller: Fulfiller<Model>?)
    {
        self.fulfiller = fulfiller
    }
    
    // MARK: Parser
    
    public override func parse(body body: Any) -> [Model]
    {
        guard let dictionary = body as? [String : AnyObject]
        else {
            return []
        }
        
        return self.parse(dictionary: dictionary)
    }
    
    public func fulfill(object: Model, json: NSDictionary) -> Model
    {
        if let fulfiller = self.fulfiller {
            return fulfiller.fulfill(object, json: json)
        }
        
        return object
    }
    
    public func parse(json json: JSON) -> [Model]
    {
        var objects:[Model] = []
        if let dictionary = json.dictionary {
            if let object = parseObject(dictionary) {
                objects.append(object)
            }
            
            for (_, keyData) in dictionary {
                objects.appendContentsOf(parse(json: keyData))
            }
        } else if let array = json.array {
            for itemData in array {
                objects.appendContentsOf(parse(json: itemData))
            }
        }
        
        return objects
    }
    
    internal func parse(dictionary dictionary: [String : AnyObject]) -> [Model]
    {
        let json = JSON(dictionary)
        return parse(json: json)
    }
    
}