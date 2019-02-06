//
//  NavigateConfigurator.swift
//  ProjectName
//
//  Created by 佐藤 慎 on 2018/04/06.
//Copyright © 2018年 'OrganizationName'. All rights reserved.
//

import Foundation
import UIKit
//import Compass

//protocol Navigatable {
//    var scheme: String { get }
//    var routes: [String: Routable] { get }
//}
//
///**
// Compass + R-Swift を利用したルーター実装例
// 
// Navigatorの初期化を行う
// 
// 参考記事
// https://bit.ly/2GyBtQK
// */
//public class NavigateConfigurator: Navigatable {
//    
//    public static let shared = NavigateConfigurator()
//    
//    public var scheme: String = "ProjectName"
//    
//    public var routes: [String: Routable] = [
//        SampleTopRoute.key: SampleTopRoute(),
//        SampleDetailRoute.key: SampleDetailRoute(),
//        SampleLoginRoute.key: SampleLoginRoute()
//    ]
//    
//    private (set) var router: Router = Router()
//    
//    public func configure() {
//        Navigator.scheme = scheme
//        router.routes = routes
//        Navigator.routes = Array(routes.keys)
//        
//        Navigator.handle = { [weak self] location in
//            let arguments = location.arguments
//            print(arguments)
//            
//            guard let rootVC = UIApplication.shared.delegate?.window??.rootViewController else {
//                Log.debug("rootViewControllerが取得できない")
//                return
//            }
//            
//            self?.router.navigate(to: location, from: rootVC)
//        }
//    }
//    
//}
