//
//  GitHub_SwiftByStartsTests.swift
//  GitHub SwiftByStartsTests
//
//  Created by Filipe Merli on 18/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import XCTest
@testable import GitHub_SwiftByStarts

class GitHub_SwiftByStartsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecodeJsonRepo() {

        XCTAssertNoThrow(try JSONDecoder().decode(Repositorie.self, from: repoWithNoStar))
        XCTAssertThrowsError(try JSONDecoder().decode(Repositorie.self, from: repoWithNoName))

    }
    
    private let repoWithNoName = Data("""
        {
            "name": null,
            "owner": {
                "login": "filipemerli",
                "avatar_url": "https://avatars0.githubusercontent.com/u/31779152?v=4"
            },
            "stargazers_count": 1000
        }
        """.utf8)
    
    private let repoWithNoStar = Data("""
        {
            "name": "repo name",
            "owner": {
                "login": "filipemerli",
                "avatar_url": "https://avatars0.githubusercontent.com/u/31779152?v=4"
            },
            "stargazers_count": null
        }
        """.utf8)

}
