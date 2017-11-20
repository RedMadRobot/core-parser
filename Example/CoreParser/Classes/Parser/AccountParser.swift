//
//  AccountParser.swift
//  Parser
//
//  Created by  Anton Poderechin on 31/01/16.
//  Copyright © 2016 RedMadRobot. All rights reserved.
//

import Foundation
import CoreParser


class AccountParser: JSONParser<Account> {
    
    override func parseObject(_ data: JSON) -> Account?
    {
        printAbsentFields(in: data)
        
        guard
            let entityId = data["id"]?.string,
            let name = data["name"]?.string,
            let legsCount = data["legs_count"]?.int,
            let legsLength = data["legs_length"]?.double,
            let internalName = data["internal"]["name"]?.string,
            let smth = data["is_smth"]?.bool
        else {
            return nil
        }
        
        let object = Account()
        object.entityId = entityId
        object.name = name
        object.legsCount = legsCount
        object.legsLength = legsLength
        object.internalName = internalName
        object.isSmth = smth
        
        return object
    }
    
    
    override class func modelFields() -> Fields
    {
        return Fields(
            mandatory: Set([
                "id", "name", "legs_count", "legs_length", "is_smth", "internal"
                ]),
            optional: Set([
                
                ])
        )
    }
    
}
