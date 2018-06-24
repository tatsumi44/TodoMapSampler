//
//  AppDelegate.swift
//  MapTodoSample
//
//  Created by tatsumi kentaro on 2018/06/19.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import UserNotifications
import MapKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                if error != nil {
                    return
                }
                
                if granted {
                    debugPrint("通知許可")
                } else {
                    debugPrint("通知拒否")
                }
            })
            
        } else {
            // iOS 9
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
//        let center = UNUserNotificationCenter.current()
//        center.delegate = self as! UNUserNotificationCenterDelegate
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle" // 新登場！
        content.body = "Body"
        content.sound = UNNotificationSound.default()
        
        
        
        // 5秒後に発火
        let trigger: UNNotificationTrigger
        let coordinate = CLLocationCoordinate2DMake(35.6972484989424, 139.439033372458)
        let region = CLCircularRegion(center: coordinate, radius: 1000.0, identifier: "description")
        trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        let request = UNNotificationRequest(identifier: "normal",
                                            content: content,
                                            trigger: trigger)
        // ローカル通知予約
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        // Override point for customization after application launch.
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

