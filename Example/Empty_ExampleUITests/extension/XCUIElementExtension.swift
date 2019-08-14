import Foundation
import XCTest

extension XCUIElement {
    func assertShown(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(exists, message(), file: file, line: line)
    }

    func assertNotShown(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        XCTAssertFalse(exists, message(), file: file, line: line)
    }
}
