//
//  NotificationPayloadTests.swift
//  ProjectNameTests
//
//  Created by 佐藤 慎 on 2018/07/30.
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

import XCTest
@testable import ProjectName

class NotificationPayloadTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_UserInfoを渡して生成と値のマッピングが成功すること() {
        let badge = 7
        let contentAvailable = 1
        let alertDict = ["body": "alertのbody", "title": "alertのtitle"]
        
        let userInfo: [AnyHashable: Any] = ["id": 1234, "aps": [
            "alert": alertDict,
            "badge": badge,
            "content-available": contentAvailable,
            "sound": "default"
            ]
        ]
        
        let payload = NotificationPayload(userInfo: userInfo)
        XCTAssertTrue(payload?.aps?.contentAvailable == contentAvailable)
        XCTAssertTrue(payload?.aps?.badge == badge)
        XCTAssertTrue(payload?.aps?.sound == "default")
        XCTAssertTrue(payload?.aps?.alert?.body == alertDict["body"])
        XCTAssertTrue(payload?.aps?.alert?.title == alertDict["title"])
    }
    
    func test_Userinfo内にキーが存在ない場合はPayloadの生成は成功するがプロパティ呼び出しでnilが返ってくること() {
        let userInfo: [AnyHashable: Any] = ["id": 1234, "aps": [
            "alert": ["body": "alertのbody", "title": "alertのtitle"]
            ]
        ]
        
        let payload = NotificationPayload(userInfo: userInfo)
        XCTAssertNil(payload?.aps?.contentAvailable)
        XCTAssertNil(payload?.aps?.badge)
    }
    
    func test_Userinfoの構造が仕様に準拠してない場合は生成したPayloadの中身がnilになること() {
        let userInfo: [AnyHashable: Any] = ["id": 1234, "aps": [
            "alert": "Alertが仕様に準拠していない",
            "badge": 1,
            "content-available": 1,
            "sound": "default"
            ]
        ]
        
        let payload = NotificationPayload(userInfo: userInfo)
        XCTAssertNil(payload)
    }
}
