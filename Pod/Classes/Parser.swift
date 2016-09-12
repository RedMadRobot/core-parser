//
//  Parser.swift
//  Pods
//
//  Created by Egor Taflanidi on 25.03.16.
//
//

import Foundation


open class Parser<Model> {
    
    // MARK: Abstract
    
    /* abstract */ open func parse(_ data: Any) -> [Model]
    {
        preconditionFailure("Необходимо переопределить метод Parser.parse()")
    }
}
