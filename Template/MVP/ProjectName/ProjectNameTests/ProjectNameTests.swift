//
//  ProjectNameTests.swift
//  ProjectNameTests
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import XCTest
@testable import ProjectName

class ProjectNameTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCheckingFetchUser() {
        let expectation = self.expectation(description: "wait for test")
        let model = SampleModel()
        model.fetchUser(query: "apple") { (result) in
            result
                .ifSuccess { users in
                    XCTAssertTrue(!users.isEmpty)
                }.ifError { error in
                    XCTFail("\(error)")
                }
            expectation.fulfill()
        }
         wait(for: [expectation], timeout: 10.0)
    }
    
}
