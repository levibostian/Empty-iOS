import Empty
import XCTest

class EmptyViewTests: XCTestCase {
    private var emptyView: EmptyView!

    override func setUp() {
        super.setUp()

        emptyView = EmptyView()
    }

    func test_init_noSubviews() {
        XCTAssertNil(emptyView.titleLabel)
        XCTAssertNil(emptyView.messageLabel)
        XCTAssertTrue(emptyView.buttons.isEmpty)
        XCTAssertTrue(emptyView.labelsContainer.arrangedSubviews.isEmpty)
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_setTitle_expectLabelAdded() {
        let title = "title"
        emptyView.title = title

        XCTAssertNotNil(emptyView.titleLabel)
        XCTAssertNil(emptyView.messageLabel)
        XCTAssertTrue(emptyView.buttons.isEmpty)
        XCTAssertTrue(emptyView.labelsContainer.arrangedSubviews.contains(emptyView.titleLabel!))
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.isEmpty)

        XCTAssertEqual(emptyView.titleLabel?.text, title)
    }

    func test_setMessage_expectLabelAdded() {
        let message = "message"
        emptyView.message = message

        XCTAssertNil(emptyView.titleLabel)
        XCTAssertNotNil(emptyView.messageLabel)
        XCTAssertTrue(emptyView.buttons.isEmpty)
        XCTAssertTrue(emptyView.labelsContainer.arrangedSubviews.contains(emptyView.messageLabel!))
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.isEmpty)

        XCTAssertEqual(emptyView.messageLabel?.text, message)
    }

    func test_setTitleThenNil_expectRemoveLabel() {
        let title = "title"
        emptyView.title = title
        emptyView.title = nil

        XCTAssertNil(emptyView.titleLabel)
        XCTAssertNil(emptyView.messageLabel)
        XCTAssertTrue(emptyView.buttons.isEmpty)
        XCTAssertTrue(emptyView.labelsContainer.arrangedSubviews.isEmpty)
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_setMessageThenNil_expectRemoveLabel() {
        let message = "message"
        emptyView.message = message
        emptyView.message = nil

        XCTAssertNil(emptyView.titleLabel)
        XCTAssertNil(emptyView.messageLabel)
        XCTAssertTrue(emptyView.buttons.isEmpty)
        XCTAssertTrue(emptyView.labelsContainer.arrangedSubviews.isEmpty)
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_addButton_expectAddsButton() {
        let id = "id"
        emptyView.addButton(id: id, message: "message")

        XCTAssertNotNil(emptyView.buttons[id])

        let addedButton = emptyView.buttons[id]!
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.contains(addedButton))
    }

    func test_addMultipleButtons_expectAddsButtons() {
        let id = "id"
        emptyView.addButton(id: id, message: "message")
        let otherId = "otherId"
        emptyView.addButton(id: otherId, message: "message")

        let addedButton = emptyView.buttons[id]!
        let otherAddedButton = emptyView.buttons[otherId]!
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.contains(addedButton))
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.contains(otherAddedButton))
    }

    func test_addAndRemoveButton_expectButtonRemoved() {
        let id = "id"
        emptyView.addButton(id: id, message: "message")
        emptyView.removeButton(id: id)

        XCTAssertNil(emptyView.buttons[id])
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_removeButton_buttonNotAdded_expectOk() {
        emptyView.removeButton(id: "foo")
    }

    func test_resetView_removesAllViews() {
        emptyView.title = "title"
        emptyView.message = "message"
        emptyView.addButton(id: "id", message: "message")

        emptyView.resetViews()

        XCTAssertNil(emptyView.titleLabel)
        XCTAssertNil(emptyView.messageLabel)
        XCTAssertTrue(emptyView.buttons.isEmpty)
        XCTAssertTrue(emptyView.labelsContainer.arrangedSubviews.isEmpty)
        XCTAssertTrue(emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_useConfig() {
        let expectCustomizeTitleLabel = XCTestExpectation(description: "Expect to customize title label")
        let expectCustomizeMessageLabel = XCTestExpectation(description: "Expect to customize message label")
        let expectCustomizeButtonLabel = XCTestExpectation(description: "Expect to customize button label")

        let changedTextColor: UIColor = .red

        let config: EmptyViewConfig = {
            let config = EmptyViewConfig()
            config.newTitleLabel = {
                let label = EmptyViewConfig.defaultTitleLabel
                label.textColor = changedTextColor
                expectCustomizeTitleLabel.fulfill()
                return label
            }
            config.newMessageLabel = {
                let label = EmptyViewConfig.defaultMessageLabel
                label.textColor = changedTextColor
                expectCustomizeMessageLabel.fulfill()
                return label
            }
            config.newButton = {
                let button = EmptyViewConfig.defaultButton
                button.setTitleColor(changedTextColor, for: .normal)
                expectCustomizeButtonLabel.fulfill()
                return button
            }
            return config
        }()
        emptyView.config = config

        emptyView.title = "title"
        emptyView.message = "message"
        emptyView.addButton(id: "id", message: "message")

        wait(for: [expectCustomizeTitleLabel, expectCustomizeMessageLabel, expectCustomizeButtonLabel], timeout: TestUtil.timeoutDefault)

        XCTAssertEqual(emptyView.titleLabel?.textColor, changedTextColor)
        XCTAssertEqual(emptyView.messageLabel?.textColor, changedTextColor)
        XCTAssertEqual(emptyView.buttons["id"]?.titleLabel?.textColor, changedTextColor)
    }
}
