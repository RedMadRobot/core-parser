//
//  AppDelegate.swift
//  CoreParser
//
//  Created by  Anton Poderechin on 02/14/2016.
//  Copyright (c) 2016  Anton Poderechin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        ParserTest().run()
        return true
    }

}

