//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/3/3.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        logBuildConfigurationSettings()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVc = EZNavigationController(rootViewController: ViewController())
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        
        // 命令模式测试入口
//        designPatternsEntry()
//        arrayEntry()
//        protocolEntry()
        
        return true
    }
    
    private func logBuildConfigurationSettings() {
        var settings = "App Environment"
        #if DEBUG
            settings += " Project-debug"
        #elseif BETA
            settings += " Project-internal"
        #elseif PROD
            settings += " Project-appStore"
        #else
            settings += " Project-null"
        #endif
                    
        #if TARGET_DEBUG
            settings += " Target-debug"
        #elseif TARGET_DETA
            settings += " Target-internal"
        #elseif TARGET_PROD
            settings += " Target-appStore"
        #else
            settings += " Target-null"
        #endif
        print("\n>>>>>>>>>>>>>>>>> ", settings, " <<<<<<<<<<<<<<<<<<\n")
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


    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return window?.rootViewController?.supportedInterfaceOrientations ?? .portrait
    }
    
}


