//
//  ConstTarget.swift
//  ProjectName
//
//  Created by AuthorName.
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

import Foundation

public struct NotificationPayload {
    
    private (set) var aps: NotificationAPS?
    
    init?(userInfo: [AnyHashable: Any]) {
        do {
            guard let dict = userInfo["aps"] else {
                return nil
            }
            // MEMO: json変換時のオーバーヘッドが気になる場合はMoreCodableのDictionaryEncoder/Decoder的なものを実装して利用する
            // https://bit.ly/2vnHMhR  https://bit.ly/2LNZtRJ
            let json = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            self.aps = try JSONDecoder().decode(NotificationAPS.self, from: json)
        } catch {
            return nil
        }
    }
}
