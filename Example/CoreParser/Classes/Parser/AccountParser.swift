//
//  AccountParser.swift
//  Parser
//
//  Created by  Anton Poderechin on 31/01/16.
//  Copyright © 2016 BrosJam. All rights reserved.
//

import Foundation
import CoreParser
import SwiftyJSON


class AccountParser: JSONParser<Account> {
    
    //MARK: JSONParser
    
    init()
    {
        super.init(fulfiller: nil)
    }
    
    override func parseObject(data: [String : JSON]) -> Account?
    {
        guard
            let entityId = data["id"]?.string,
            let name = data["name"]?.string,
            let legsCount = data["legs_count"]?.int,
            let legsLength = data["legs_length"]?.float
        else {
            return nil;
        }
        
        let object = Account()
        object.entityId = entityId
        object.name = name
        object.legsCount = legsCount
        object.legsLength = legsLength
        
        return object
    }
    
}