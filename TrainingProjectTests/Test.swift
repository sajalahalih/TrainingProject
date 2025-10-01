//
//  Test.swift
//  TrainingProjectTests
//
//  Created by saja allahaleh on 01/10/2025.
//

import XCTest
import Testing
@testable import TrainingProject
import Foundation

class AuthManager {
    func login(username: String, password: String) -> Bool {
        return username == "saja" && password == "123"
    }
}

class Test: XCTestCase {

    var auth: AuthManager? = AuthManager()
    override func setUp() {
        super.setUp()
        auth = AuthManager()
    }
    override func tearDown() {
        auth = nil
        super.tearDown()
    }
    func testAddition() {
        let result = 1 + 1
        XCTAssertEqual(result, 2)
    }
    func testLoginSucceedsWithCorrectCredentials() {
        XCTAssertTrue(((auth!.login(username: "saja", password: "123"))))
        }

    func testLoginFailsWithWrongPassword() {
        XCTAssertFalse(auth!.login(username: "admin", password: "wrong"))
        }

//    @Test func example() async throws {
//        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//    }
    func testIsEvenNumber() {
        XCTAssertTrue(MathUtils.isEven(4))
        XCTAssertFalse(MathUtils.isEven(5))
    }
    func testPerformanceExample() {
        self.measure {
            _ = Array(0...1000).sorted()
        }
    }

}
struct MathUtils {
    static func isEven(_ num: Int) -> Bool {
        return num % 2 == 0
    }
}
