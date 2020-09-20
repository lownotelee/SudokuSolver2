//
//  AppDelegate.swift
//  SudokuSolver2
//
//  Created by Lee on 8/2/19.
//  Copyright © 2019 radev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let bigSquare1 = [
            [3,0,0,7,0,4,0,9,0],
            [0,2,8,6,0,0,0,7,0],
            [0,0,0,0,0,0,0,1,2],
            [0,9,0,0,5,0,0,4,7],
            [0,5,6,1,0,0,9,0,0],
            [1,0,4,0,3,0,0,5,6],
            [5,0,2,4,0,8,7,0,1],
            [7,3,1,2,0,0,0,0,0],
            [4,0,0,3,0,0,2,6,0]
        ]
        
        window?.rootViewController = ViewController(puzzleToLoad: bigSquare1)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

