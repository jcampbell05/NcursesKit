import XCTest
@testable import NcursesKit

class NcursesKitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(NcursesKit().text, "Hello, World!")
    }


    static var allTests : [(String, (NcursesKitTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
