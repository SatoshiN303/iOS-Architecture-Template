//
//  MoreCache.swift
//  ProjectName
//
//  Created by AuthorName.
//  Copyright © 2018 'OrganizationName'. All rights reserved.
//
import Foundation

/*
 URLCacheをHTTPレスポンスヘッダの有効期限に準拠させたカスタムクラス
 
 レスポンスのExpires, max-ageいずれかの有効期限を確認して
 積極的にキャッシュを利用します。

 保持: 有効期限を見て必要なものだけキャッシュする
 取得: 有効期限が過ぎているものは新しく取得しにいく
 上限: キャッシュ上限を超えたら古いデータから削除
 
 参考: https://bit.ly/2GiM2aJ
 Nuke.Cacheと名前衝突していたのでマニュアルインストールです
 */
class MoreCache: URLCache {
    
    // 強制的にキャッシュしたい場合に
    private (set) var minimumAge = 0
    private var excludable: CacheExcludable?
    
    // MARK: - Initializer
    
    init(memoryCapacity: Int, diskCapacity: Int, diskPath path: String?, excludable: CacheExcludable? = nil) {
        super.init(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: path)
        self.excludable = excludable
    }

    // MARK: - Cache
    
    override func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        let cache = super.cachedResponse(for: request)
        
        guard let httpResponse = cache?.httpResponse else {
            return nil
        }
        if isPastDate(httpResponse.header.expires) {
            return nil
        }
        guard excludable?.canRespondCache(with: httpResponse) != false else {
            return nil
        }
        
        return cache
    }

    override func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        guard let httpResponse = cachedResponse.httpResponse else {
            return
        }
        if isPastDate(httpResponse.header.expires) {
            return
        }
        if excludable?.canStoreCache(with: httpResponse) != false {
            super.storeCachedResponse(cachedResponse, for: request)
        }
    }

    // MARK: - Helper
    
    func isPastDate(_ target: Date?) -> Bool {
        guard let target = target else {
            return false
        }
        let current = Date()

        if minimumAge == 0 {
            return current > target
        }
        
        if minimumAge >= 1 {
            let components = DateComponents(second: -minimumAge)
            let calendar = Calendar(identifier: .gregorian)
            if let date = calendar.date(byAdding: components, to: current) {
                return date > target
            }
        }
        
        return false
    }
    
    func setMinimuAge(_ value: Int, dateString: String? = nil) {
        if let dateString = dateString {
            let df = DateFormatter()
            df.locale = Locale(identifier: "en_US_POSIX")
            df.dateFormat = "E, dd M yyyy HH:mm:ss Z"
            if let date = df.date(from: dateString) {
                minimumAge = Int(Date().timeIntervalSince(date)) + 1000
            }
            return
        }
        minimumAge = value
    }
    
}

private extension CachedURLResponse {
    var httpResponse: HTTPURLResponse? {
        return response as? HTTPURLResponse
    }
}

// レスポンスヘッダ確認用プロトコル
protocol CacheExcludable {
    func canRespondCache(with httpResponse: HTTPURLResponse) -> Bool
    func canStoreCache(with httpResponse: HTTPURLResponse) -> Bool
}
