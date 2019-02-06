//
//  Log.swift
//  ProjectName
//
//  Created by AuthorName 
//  Copyright © 2018 'OrganizationName'. All rights reserved.
//

import Foundation
import os.log

/*
 ロギング用クラス
 案件の用途によってCrashlyticsのログと組合わせて活用して下さい
 参考: https://bit.ly/2pOd66n
 */
final class Log {
    
    // ログレベル用enum
    private enum Level: CustomStringConvertible {
        case debug, fatal
        
        var description: String {
            switch self {
            case .debug: return "⚒"
            case .fatal: return "😱"
            }
        }
    }
    
    private init() {}
    
    // コンソール出力のみ
    static func debug(_ message: String) {
        log(message, .debug)
    }
    
    // コンソール出力, Debugビルドでassertion発動
    static func fatal(_ message: String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        log(message, .fatal)
        let fileName = file.components(separatedBy: "/").last ?? ""
        let error = NSError(
            domain: "\(fileName):\(function)",
            code: line,
            userInfo: ["message": message]
        )
        log(error.description, .fatal)
        assertionFailure(message)
    }
    
    // コンソール:出力, 保存先:なし
    private static func log(_ message: String, _ level: Level) {
        os_log("%@%@", log: .default, type: .debug, level.description, message)
    }
}
