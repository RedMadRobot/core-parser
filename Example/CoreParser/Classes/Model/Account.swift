//
//  Account.swift
//  Parser
//
//  Created by  Anton Poderechin on 31/01/16.
//  Copyright © 2016 RedMadRobot. All rights reserved.
//

import Foundation


/**
    Entity for user account
 */
class Account: Model {
    
    var entityId = ""
    
    var name = ""
    
    var createdAt: NSDate = NSDate()
    
    var legsCount: Int = 0
    
    var legsLength: Double = 0.0
    
    var internalName: String = ""
    
    var isSmth = false
}
