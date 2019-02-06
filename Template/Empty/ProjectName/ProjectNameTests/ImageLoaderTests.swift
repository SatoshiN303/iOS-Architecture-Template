//
//  ImageLoaderTests.swift
//  ProjectNameTests
//
//  Created by 佐藤 慎 on 2018/04/02.
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

import XCTest
@testable import ProjectName

class ImageLoaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test_画像URLからの画像ロードが成功すること() {
        let url = URL(string: "http://via.placeholder.com/350x150")!
        let loadExpectation = expectation(description: "ImageLoader.load")
        ImageLoader.shared.nuke.loadImage(with: url) { (result) in
            XCTAssertNil(result.error)
            XCTAssertNotNil(result.value)
            loadExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
}
