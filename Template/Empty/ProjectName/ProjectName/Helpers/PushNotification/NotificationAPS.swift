//
//  NotificationAPS.swift
//  ProjectName
//
//  Created by 佐藤 慎 on 2018/07/27.
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//
//  https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/PayloadKeyReference.html#//apple_ref/doc/uid/TP40008194-CH17-SW1

import Foundation

public struct NotificationAPS: Codable {
    let alert: NotificationAlert?
    let badge: Int?
    let sound: String?
    let contentAvailable: Int?
    let category: String?
    let threadId: String?
        
    enum CodingKeys: String, CodingKey {
        case
        alert,
        badge,
        sound,
        contentAvailable = "content-available",
        category,
        threadId = "thread-id"
    }
}
