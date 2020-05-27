import XCTest
@testable import FitnessGym

final class FitnessGymTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FitnessGym().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
