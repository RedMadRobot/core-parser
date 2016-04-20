//
//  Parser.swift
//  Pods
//
//  Created by Egor Taflanidi on 25.03.16.
//
//

import Foundation


public class Parser<Model> {
    
    // MARK: Abstract
    
    /* abstract */ public func parse(body body: Any) -> [Model]
    {
        preconditionFailure("Необходимо переопределить метод Parser.parse()")
    }
    
}