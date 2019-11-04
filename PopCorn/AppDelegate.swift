//
//  AppDelegate.swift
//  PopCorn
//
//  Created by 間瀬真 on 2019/11/02.
//  Copyright © 2019 間瀬真. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import CoreBluetooth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate, CBCentralManagerDelegate,CBPeripheralDelegate  {
    
    var window: UIWindow?
    var myCentralManager: CBCentralManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("called application init")
        FirebaseApp.configure()
        
        if #available(iOS 10.0, *) {
            print("called ios10.0")
          // For iOS 10 display notification (sent via APNS)
            Messaging.messaging().delegate = self
            UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
            print("called not ios10.0")
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        //ios13以前のView起動
        if #available(iOS 13, *) {
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            self.window = window
            window.makeKeyAndVisible()

            let vc = ViewController()
            window.rootViewController = vc
        }
        
        // CoreBluetoothを初期化および始動.
        myCentralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
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
    
        // デバイストークンが取得されたら呼び出されるメソッド
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

            print("called function application didRegisterForRemoteNotificationsWithDeviceToken")
            
             let deviceTokenStr: String = deviceToken.reduce("", { $0 + String(format: "%02X", $1) })
            print("APNsトークン: \(deviceTokenStr)")

            // APNsトークンを、FCM登録トークンにマッピング
            Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    //MessagingDelegate
     //
     func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
         print("Firebase Registration Token: \(fcmToken)")
         
         let dataDict:[String: String] = ["token": fcmToken]
         NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
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
    
    //CoreBluetooth
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("state \(central.state)");

        switch (central.state) {
            
        case .poweredOff:
                print("Bluetoothの電源がOff")
            case .poweredOn:
                print("Bluetoothの電源はOn")
                // BLEデバイスの検出を開始.
                myCentralManager.scanForPeripherals(withServices: nil, options: nil)
            case .resetting:
                print("レスティング状態")
            case .unauthorized:
                print("非認証状態")
            case .unknown:
                print("不明")
            case .unsupported:
                print("非対応")
        }
    }
    
    //デバイス検出時に実行される
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String, name.lowercased().contains("btnbcn") {
            
            print("pheripheral.name: \(peripheral.name)")
            print("advertisementData:\(advertisementData)")
            print("RSSI: \(RSSI)")
            print("peripheral.identifier.UUIDString: \(peripheral.identifier.uuidString)")
        }
    }

}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler()
    }
}
