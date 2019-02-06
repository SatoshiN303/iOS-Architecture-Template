//
//  HTTPURLResponse+CacheControl.swift
//  ProjectName
//
//  Created by AuthorName.
//  Copyright © 2018 'OrganizationName'. All rights reserved.
//
import Foundation

extension HTTPURLResponse {
    struct CacheControl {

        // 期限切れだった場合オリジンサーバでの確認無しにキャッシュを利用してはならない
        var mustRevalidate: Bool {
            return values.contains("must-revalidate")
        }
        // オリジンサーバでの確認無しにキャッシュを利用してはならない
        var noCache: Bool {
            return values.contains("no-cache")
        }
        // リクエスト、レスポンスの一切を保存してはならない
        var noStore: Bool {
            return values.contains("no-store")
        }
        // 中継者は形式変換してはならない（画像の再圧縮等を防ぐ）
        var noTransform: Bool {
            return values.contains("no-transform")
        }
        // 複数ユーザーで共有できるようにキャッシュしてよい（主にキャッシュサーバ）
        var `public`: Bool {
            return values.contains("public")
        }
        // 特定ユーザーだけが使えるようにキャッシュしてよい（主にブラウザ）
        var `private`: Bool {
            return values.contains("private")
        }
        // privateキャッシュには適用されないことを除きmust-revalidateと同じ
        var proxyRevalidate: Bool {
            return values.contains("proxy-revalidate")
        }
        // キャッシュの有効期限を設定する（秒）
        var maxAge: Int? {
            return value(for: "max-age").flatMap(Int.init)
        }
        // 共有キャッシュにてmax-ageまたはExpiresヘッダで指定された値を上書き
        var sMaxAge: Int? {
            return value(for: "s-maxage").flatMap(Int.init)
        }
        
        private let values: [Substring]
        
        private func value(for key: String) -> String? {
            return values.filter { $0.contains(key) }.first.flatMap { $0.split(separator: "=").last }.map(String.init)
        }
        
        init(string: String) {
            values = string.replacingOccurrences(of: " ", with: "").split(separator: ",")
        }
    }
}
