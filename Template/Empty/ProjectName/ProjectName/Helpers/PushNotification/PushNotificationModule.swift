//
//  NotificationHelper.swift
//  ProjectName
//
//  Created by AuthorName.
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
//import NCMB

struct PushNotificationModule {
    
    enum UsedService {
        case nifty
        case aws
    }
    
    static let shared = PushNotificationModule()
    static let usedService = UsedService.nifty
    
    static var isRegistered: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "didRegisterPushNotification")
            UserDefaults.standard.synchronize()
        }
        
        get {
            return UserDefaults.standard.bool(forKey: "didRegisterPushNotification")
        }
    }
    
    // push通知周りの初期化
    func registerForRemote() {
        
        if PushNotificationModule.isRegistered {
            return
        }
        
        configurePushService()
        
        // デバイストークンの要求
        if #available(iOS 10.0, *) {
            /** iOS10以上 **/
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .badge, .sound]) {granted, error in
                if error != nil {
                    return
                }
                if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            /** iOS8以上iOS10未満 **/
            let app = UIApplication.shared
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            app.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }
        
    }
    
    /// アプリ起動時にpushあるか確認する
    func didFinishLaunching(options: [UIApplicationLaunchOptionsKey: Any]?) {
       clearAppIconBadge()
        
        guard let userInfo = options?[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] else {
            return
        }
        
        guard let payload = NotificationPayload(userInfo: userInfo) else {
            return
        }
        
        launch(with: payload)
    }
    
    /// push通知受信
    func didReceiveRemoteNotification(application: UIApplication, options: [AnyHashable: Any]) {
        
        clearAppIconBadge()
        guard let userInfo = options[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] else {
            return
        }
        
        guard let payload = NotificationPayload(userInfo: userInfo) else {
            return
        }
        
        switch application.applicationState {
        case .active:
            active(with: payload)
        case .inactive, .background:
            inActive(with: payload)
        }
    }
    
    /// デバイストークン登録用
    func didRegisterForRemoteNotificationsWithDeviceToken( _ application: UIApplication, deviceToken: Data) {
        didRegisterRemoteWithDeviceToken(deviceToken)
    }
    
    func clearAppIconBadge() {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
}

// MARK: - Behavior for each activation state
extension PushNotificationModule {
    fileprivate func launch(with payload: NotificationPayload) {
        // 起動時にpushがあった場合の処理
    }
    
    fileprivate func inActive(with payload: NotificationPayload) {
        // アプリの操作などができない状態からpushを受け取った時の処理
    }
    
    fileprivate func active(with payload: NotificationPayload) {
        // アプリ起動中にpushを受け取った時の処理
    }
}

// MARK: - Configure
extension PushNotificationModule {
    
    private struct ConstNCMB {
        static let applicationKeyString = Bundle.main.readStringObject("NCMB_APPLICATION_KEY")
        static let clientKeyString = Bundle.main.readStringObject("NCMB_CLIENT_KEY")
    }
    
    private struct ConstAWS {
        static let snsPlatformArn = Bundle.main.readStringObject("AWS_SNS_PLATFORM_ARN")
    }
    
    /// ニフティクラウドでのPush通知を行う場合の各種初期設定
    fileprivate func configurePushService() {
        
        switch PushNotificationModule.usedService {
        case .nifty:
            /*
             // MEMO: プッシュ通知でニフティクラウドを使用する場合はコメントアウトで設定
             NCMB.setApplicationKey(ConstNCMB.applicationKeyString, clientKey: ConstTarget.clientKeyString) //キー設定
             NCMBAnalytics.trackAppOpened(launchOptions: launchOptions) //開封通知
             */
            break
            
        case .aws:
            break
        }
        
    }
    
    /// 端末情報をデータストアに登録
    fileprivate func didRegisterRemoteWithDeviceToken(_ deviceToken: Data) {
        
        switch PushNotificationModule.usedService {
        case .nifty:
            /*
             // MEMO: プッシュ通知でニフティクラウドを使用する場合はコメントアウトで設定
             
             // 端末情報を扱うNCMBInstallationのインスタンスを作成
             let installation = NCMBInstallation.current()
             installation?.setDeviceTokenFrom(deviceToken)
             
             // 端末情報をデータストアに登録
             installation?.saveInBackground { (error) -> Void in
                 if (error != nil){
                    // 端末情報の登録に失敗した時の処理
                 }else{
                    // 端末情報の登録に成功した時の処理
                 }
             }
             */
            break
            
        case .aws:
            /*
            // NOTE: Data型から16進数文字列へ変換
            let deviceTokenString = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
            
            guard let request = AWSSNSCreatePlatformEndpointInput() else {
                fatalError()
            }
            request.token = deviceTokenString
            request.platformApplicationArn = Const.SNSPlatformApplicationArn
            //request.customUserData = "INNER_USER"
            
            let sns = AWSSNS.default()
            sns.createPlatformEndpoint(request).continueWith { (task) -> Any? in
                guard task.error == nil else {
                    debugLog("Error: \(task.error)")
                    return nil
                }
                guard let _ = task.result else {
                    debugLog("Error: No Result")
                    return nil
                }
                PushNotificationService.isRegisterd = true
                return nil
            }
            */
            break
        }
    }
    
}
