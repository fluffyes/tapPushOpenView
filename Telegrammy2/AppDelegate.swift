//
//  AppDelegate.swift
//  Telegrammy2
//
//  Created by Soulchild on 15/04/2020.
//  Copyright © 2020 fluffy. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // to perform action when notification is tapped
        UNUserNotificationCenter.current().delegate = self
        
        registerForPushNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func registerForPushNotifications() {
           UNUserNotificationCenter.current()
               .requestAuthorization(options: [.alert, .sound, .badge]) {
                   [weak self] granted, error in
                   
                   print("Permission granted: \(granted)")
                   guard granted else { return }
                   self?.getNotificationSettings()
           }
       }
       
       func getNotificationSettings() {
           UNUserNotificationCenter.current().getNotificationSettings { settings in
               print("Notification settings: \(settings)")
               guard settings.authorizationStatus == .authorized else { return }
               DispatchQueue.main.async {
                   UIApplication.shared.registerForRemoteNotifications()
               }
           }
       }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let application = UIApplication.shared
        
        if(application.applicationState == .active){
            print("user tapped the notification bar when the app is in foreground")
            
        }
        
        if(application.applicationState == .inactive)
        {
            print("user tapped the notification bar when the app is in background")
        }
        
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else {
            return
        }
        
        print("got active scene")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // instantiate the view controller from storyboard
        // root view controller is tab bar controller
        // the selected tab contains navigation controller
        // then we push the new view controller to it
        if  let conversationVC = storyboard.instantiateViewController(withIdentifier: "ConversationViewController") as? ConversationViewController,
            let tabBarVC = rootViewController as? UITabBarController,
            let navVC = tabBarVC.selectedViewController as? UINavigationController {
            
            // we can modify variable of the view controller using notification data
            // (eg: title of notification)
            // response.notification.request.content.userInfo
                conversationVC.senderDisplayName = response.notification.request.content.title
            
                navVC.pushViewController(conversationVC, animated: true)
        }

        completionHandler()
    }
}

