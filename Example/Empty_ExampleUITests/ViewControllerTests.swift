//
//  Empty_ExampleUITests.swift
//  Empty_ExampleUITests
//
//  Created by Levi Bostian on 8/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import Pods_Empty_Example

class ViewControllerTests: XCTestCase {
    var app: XCUIApplication!
    var viewController: ViewControllerPageObject!

    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")

        viewController = ViewControllerPageObject(app: app)
    }

    override func tearDown() {}

    func test_coldStart_viewShowingCorrectViews() {
        app.launch()

        viewController.emptyView.assertShown()
        viewController.titleLabel.assertShown()
        viewController.messageLabel.assertShown()
        viewController.retryButton.assertShown()
        viewController.dontRetryButton.assertShown()
    }

    func test_tapRetryButton_expectSeePopup() {
        app.launch()

        viewController.retryButton.tap()
        viewController.retryAlert.assertShown()
    }

    func test_tapDontRetryButton_expectSeePopup() {
        app.launch()

        viewController.dontRetryButton.tap()
        viewController.dontRetryAlert.assertShown()
    }

}

class ViewControllerPageObject {
    let app: XCUIApplication

    var emptyView: XCUIElement {
        return app.otherElements[AccessibilityIdentifiers.emptyView]
    }

    var titleLabel: XCUIElement {
        return app.staticTexts["Error"]
    }

    var messageLabel: XCUIElement {
        return app.staticTexts["An error occurred. Would you like to retry?"]
    }

    var retryButton: XCUIElement {
        return app.buttons["Retry"]
    }

    var dontRetryButton: XCUIElement {
        return app.buttons["Dont Retry"]
    }

    var retryAlert: XCUIElement {
        return app.staticTexts["Retry button pressed"]
    }

    var dontRetryAlert: XCUIElement {
        return app.staticTexts["Don't retry button pressed"]
    }

    init(app: XCUIApplication) {
        self.app = app
    }
}
