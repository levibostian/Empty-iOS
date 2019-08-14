//
//  XCUIElementExtension.swift
//  Empty_ExampleUITests
//
//  Created by Levi Bostian on 8/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

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
