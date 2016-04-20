//
//  ParserTest.swift
//  Parser
//
//  Created by  Anton Poderechin on 31/01/16.
//  Copyright © 2016 BrosJam. All rights reserved.
//

import Foundation
import CoreParser


class ParserTest {
    
    func run()
    {
        let jsonData: NSData = loadJSON()
        let parser = createParser()
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! [String: AnyObject]
            let objects = parser.parse(body: json)
            print("Objects count: \(objects.count)")
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func loadJSON() -> NSData
    {
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")
        return NSData(contentsOfFile: path!)!
    }
    
    func createParser() -> Parser<Account>
    {
        return AccountParser()
    }
}