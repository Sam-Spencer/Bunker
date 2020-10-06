import XCTest
@testable import Bunker

final class BunkerTests: XCTestCase {
    
    func testNotNil() {
        XCTAssertNotNil(Bunker.stack)
    }

    static var allTests = [
        ("testNotNil", testNotNil),
    ]
}
