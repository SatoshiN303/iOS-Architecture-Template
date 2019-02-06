//
//  NotificationAlert.swift
//  ProjectName
//
//  Created by 佐藤 慎 on 2018/07/27.
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//
//  https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/PayloadKeyReference.html#//apple_ref/doc/uid/TP40008194-CH17-SW1

import Foundation

public struct NotificationAlert: Codable {
    let title: String?
    let subtitle: String?
    let body: String?
    let titleLocalizationKey: String?
    let titleLocalizationArguments: [String]?
    let actionLocalizationKey: String?
    let bodyLocalizationKey: String?
    let bodyLocalizationArguments: [String]?
    let launchImage: String?
        
    enum CodingKeys: String, CodingKey {
        case
        title,
        subtitle,
        body,
        titleLocalizationKey = "title-loc-key",
        titleLocalizationArguments = "title-loc-args",
        actionLocalizationKey = "action-loc-key",
        bodyLocalizationKey = "loc-key",
        bodyLocalizationArguments = "loc-args",
        launchImage = "launch-image"
    }
}
