//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Yue Bai on 12/24/14.
//  Copyright (c) 2014 Yue Bai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let barfont = UIFont(name: "ProximaNova-Regular", size: 18)
        if let font = barfont {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : font],
                forState:UIControlState.Normal)
        }
        var firstValue : Float = 0.1
        NSUserDefaults.standardUserDefaults().setFloat(firstValue, forKey: FV)
        var secondValue : Float = 0.15
        NSUserDefaults.standardUserDefaults().setFloat(secondValue, forKey: SV)
        var thirdValue : Float = 0.2
        NSUserDefaults.standardUserDefaults().setFloat(thirdValue, forKey: TV)
        NSUserDefaults.standardUserDefaults().synchronize()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        NSUserDefaults.standardUserDefaults().setObject(NSDate(), forKey: "time")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits

    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if NSUserDefaults.standardUserDefaults().objectForKey("time") != nil {
            let lastDate : NSDate = NSUserDefaults.standardUserDefaults().objectForKey("time") as NSDate
            let currentDate : NSDate = NSDate()
            let interval = currentDate.timeIntervalSinceDate(lastDate)
            if interval/60.0 > 10.0 {
                NSUserDefaults.standardUserDefaults().removeObjectForKey("bill")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

