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

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        ParserTest().run()
        
        return true
    }

}

