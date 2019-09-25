import XCTest
@testable import Bedrock

final class BedrockTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Bedrock().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
