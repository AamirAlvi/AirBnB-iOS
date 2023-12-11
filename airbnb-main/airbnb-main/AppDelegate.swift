//
//  AppDelegate.swift
//  airbnb-main
//
//  Created by Yonas Stephen on 3/3/17.
//  Copyright © 2017 Yonas Stephen. All rights reserved.
//

import UIKit
import AppCenter
import AppCenterDistribute
import ContextualSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Distribute.updateTrack = .private

        #if DEBUG
        #else
            AppCenter.start(withAppSecret: "32ad9f1e-bd99-449b-baed-f87703f9afb8", services: [Distribute.self])
        #endif
        
        self.registerContextual()
        
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AirbnbMainController()        
        window?.makeKeyAndVisible()
        return true
    }

    private func registerContextual() {
        let appKey = "swift_airbnb_dj"

        
        Contextual.sharedInstance().registerGuideBlock(MultipleChoiceGuideController(), forKey: "MultipleChoiceCustom")
        Contextual.sharedInstance().registerGuideBlock(AdhocRowInsertion(), forKey: "AdhocRowInsertion")
        Contextual.sharedInstance().registerGuideBlock(CircleVideoGuide(), forKey: "FancyAnnouncement")
        Contextual.sharedInstance().registerGuideBlock(AppFieldEditGuide.sharedInstance, forKey: "AppFieldEdit")
        Contextual.sharedInstance().registerGuideBlock(ConfettiGuide(), forKey: "Confetti")
        
        Contextual.sharedInstance().registerGuideBlock(CircleVideoGuide(), forKey: "CircleVideo")

        
        Contextual.sharedInstance().registerInstall(forApp: appKey,
                                                    withDebugMode: true) {
            let createdTime = ctxFormatDate(Date())
            Contextual.sharedInstance().tagCuid("airbnb-demo \(createdTime ?? "")")
        }
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

