//
//  HTTPURLResponseExtensionsTests.swift
//  ProjectNameTests
//
//  Created by 佐藤 慎 on 2018/03/30.
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

import XCTest
@testable import ProjectName

class HTTPURLResponseExtensionsTests: XCTestCase {
    
    let url = URL(string: "http://example.com/spec")!
    let cacheControlText = "must-revalidate, no-cache, no-store, no-transform, public, private, proxy-revalidate, max-age=100, s-maxage=100"
    
    func dummyResponse(_ headerFields: [String: String]?) -> HTTPURLResponse? {
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: headerFields)
    }
    
    func test_CacheControl_HTTPURLResponseの内容を確認できること() {
        let cacheControl = HTTPURLResponse.CacheControl(string: cacheControlText)
        XCTAssertTrue(cacheControl.mustRevalidate)
        XCTAssertTrue(cacheControl.noCache)
        XCTAssertTrue(cacheControl.noStore)
        XCTAssertTrue(cacheControl.noTransform)
        XCTAssertTrue(cacheControl.public)
        XCTAssertTrue(cacheControl.private)
        XCTAssertTrue(cacheControl.proxyRevalidate)
        
        XCTAssertEqual(cacheControl.maxAge, 100)
        XCTAssertEqual(cacheControl.sMaxAge, 100)
    }
    
    func test_Header_HTTPURLResponseの内容を確認できること() {
        XCTAssertNil(dummyResponse([:])?.header.expires)
        
        XCTAssertNotNil(dummyResponse(["Cache-Control": cacheControlText])?.header.cacheControl)
        XCTAssertNil(dummyResponse(["Cache-Control": cacheControlText])?.header.expires)
        
        XCTAssertNotNil(dummyResponse(["Date": "Fri, 30 Mar 2018 11:22:38 GMT"])?.header.date)
        XCTAssertNotNil(dummyResponse(["Last-Modified": "Fri, 30 Mar 2018 11:22:38 GMT"])?.header.lastModified)
        XCTAssertNotNil(dummyResponse(["Expires": "Fri, 30 Mar 2018 11:22:38 GMT"])?.header.expires)
        
        XCTAssertNotNil(dummyResponse(["Date": "Fri, 30 Mar 2018 11:22:38 GMT"])?.header.expires)
        XCTAssertNotNil(dummyResponse(["Date": "Fri, 30 Mar 2018 11:22:38 GMT", "Cache-Control": cacheControlText])?.header.expires)
        
        XCTAssertNotNil(dummyResponse(["Etag": "HTTPURLResponse Header Etag"])?.header.etag)
        
        XCTAssertEqual(HTTPURLResponse.Header.FieldKey("Soko"), HTTPURLResponse.Header.FieldKey("Soko"))
        XCTAssertNotEqual(HTTPURLResponse.Header.FieldKey("Soko"), HTTPURLResponse.Header.FieldKey("Doko"))
    }
    
}
