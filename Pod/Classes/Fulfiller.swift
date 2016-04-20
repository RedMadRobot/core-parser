//
//  Fulfiller.swift
//  Pods
//
//  Created by  Anton Poderechin on 23/02/16.
//
//

import Foundation


public class Fulfiller<Model> {
    func fulfill(object: Model, json: NSDictionary) -> Model
    {
        preconditionFailure()
    }
}