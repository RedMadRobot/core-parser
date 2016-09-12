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
        let jsonData = loadJSON()
        let parser = createParser()
        
        do {
            let json = try JSONSerialization.jsonObject(with:jsonData, options: [])
            let objects = parser.parse(json)
            print("Objects count: \(objects.count)")
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    func loadJSON() -> Data
    {
        let path = Bundle.main.path(forResource: "data", ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path))
    }
    
    func createParser() -> Parser<Account>
    {
        return AccountParser()
    }
}
