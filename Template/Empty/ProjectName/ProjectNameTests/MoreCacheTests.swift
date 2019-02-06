//
//  MoreCacheTests.swift
//  ProjectNameTests
//
//  Created by 佐藤 慎 on 2018/03/30.
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

import XCTest
@testable import ProjectName

class MoreCacheTests: XCTestCase {
    let url = URL(string: "http://example.com/spec")!
    var request: URLRequest!
    var cache: MoreCache!

    override func setUp() {
        super.setUp()
        cache = MoreCache(memoryCapacity: 1024 * 1024 * 10, diskCapacity: 1024 * 1024 * 10, diskPath: "MoreCacheTests")
        request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
    }
    
    func test_isPastDateが正しく動作すること() {
        let calendar = Calendar.current
        let date = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: date))
        let yesterday = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: date))
        XCTAssertFalse(cache.isPastDate(tomorrow))
        XCTAssertTrue(cache.isPastDate(yesterday))
    }
    
    func test_expiresの有効期限が過ぎてるならキャッシュされないこと() {
        let dateText = "Wed, 06 Dec 2007 09:38:38 GMT"
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Expires": dateText]) else {
            XCTFail("有効期限が過ぎてるならキャッシュされないこと")
            return
        }
        let cachedResponse = CachedURLResponse(response: response, data: Data())
        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNil(cache.cachedResponse(for: request))
    }
        
    func test_expiresの有効期限が過ぎてないならキャッシュされること() {
        let dateText = "Wed, 06 Dec 2037 09:38:38 GMT"
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Expires": dateText]) else {
            XCTFail("有効期限が過ぎてないならキャッシュされること")
            return
        }
        let cachedResponse = CachedURLResponse(response: response, data: Data())
        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNotNil(cache.cachedResponse(for: request))
    }
    
    func test_expiresの有効期限が過ぎていても強制キャッシュできること() {
        let dateText = "Wed, 06 Dec 2007 09:38:38 GMT"
        guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Expires": dateText]) else {
            XCTFail("有効期限が過ぎていても強制キャッシュできること")
            return
        }
        let cachedResponse = CachedURLResponse(response: response, data: Data())
        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNil(cache.cachedResponse(for: request))
        
        cache.setMinimuAge(1000, dateString: dateText)
        cache.storeCachedResponse(cachedResponse, for: request)
        XCTAssertNotNil(cache.cachedResponse(for: request))
        
        cache.setMinimuAge(0)
        XCTAssertNil(cache.cachedResponse(for: request))
    }
    
}
