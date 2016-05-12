//
//  AppDelegate.swift
//  ReceiveFromApp
//
//  Created by Qimin Yao on 5/12/16.
//  Copyright © 2016 Qimin Yao. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
                
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        if let dataString = url.query {
            let array = dataString.componentsSeparatedByString("&")
            let name = array[0]
            let filePath = array[1]
            let dict = ["name" : name, "filePath" : filePath]
            NSNotificationCenter.defaultCenter().postNotificationName(receivedDataNotification, object: dict)
        }
        
        print(url)
        
        return true
    }
}

