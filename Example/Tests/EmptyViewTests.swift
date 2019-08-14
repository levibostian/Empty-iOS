import XCTest
import Empty

class Tests: XCTestCase {
    
    private var emptyView: EmptyView!

    override func setUp() {
        super.setUp()

        emptyView = EmptyView()
    }

    func test_init_noSubviews() {
        XCTAssertNil(self.emptyView.titleLabel)
        XCTAssertNil(self.emptyView.messageLabel)
        XCTAssertTrue(self.emptyView.buttons.isEmpty)
        XCTAssertTrue(self.emptyView.labelsContainer.arrangedSubviews.isEmpty)
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_setTitle_expectLabelAdded() {
        let title = "title"
        self.emptyView.title = title

        XCTAssertNotNil(self.emptyView.titleLabel)
        XCTAssertNil(self.emptyView.messageLabel)
        XCTAssertTrue(self.emptyView.buttons.isEmpty)
        XCTAssertTrue(self.emptyView.labelsContainer.arrangedSubviews.contains(self.emptyView.titleLabel!))
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.isEmpty)

        XCTAssertEqual(self.emptyView.titleLabel?.text, title)
    }

    func test_setMessage_expectLabelAdded() {
        let message = "message"
        self.emptyView.message = message

        XCTAssertNil(self.emptyView.titleLabel)
        XCTAssertNotNil(self.emptyView.messageLabel)
        XCTAssertTrue(self.emptyView.buttons.isEmpty)
        XCTAssertTrue(self.emptyView.labelsContainer.arrangedSubviews.contains(self.emptyView.messageLabel!))
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.isEmpty)

        XCTAssertEqual(self.emptyView.messageLabel?.text, message)
    }

    func test_setTitleThenNil_expectRemoveLabel() {
        let title = "title"
        self.emptyView.title = title
        self.emptyView.title = nil

        XCTAssertNil(self.emptyView.titleLabel)
        XCTAssertNil(self.emptyView.messageLabel)
        XCTAssertTrue(self.emptyView.buttons.isEmpty)
        XCTAssertTrue(self.emptyView.labelsContainer.arrangedSubviews.isEmpty)
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_setMessageThenNil_expectRemoveLabel() {
        let message = "message"
        self.emptyView.message = message
        self.emptyView.message = nil

        XCTAssertNil(self.emptyView.titleLabel)
        XCTAssertNil(self.emptyView.messageLabel)
        XCTAssertTrue(self.emptyView.buttons.isEmpty)
        XCTAssertTrue(self.emptyView.labelsContainer.arrangedSubviews.isEmpty)
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_addButton_expectAddsButton() {
        let id = "id"
        self.emptyView.addButton(id: id, message: "message")

        XCTAssertNotNil(self.emptyView.buttons[id])

        let addedButton = self.emptyView.buttons[id]!
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.contains(addedButton))
    }

    func test_addMultipleButtons_expectAddsButtons() {
        let id = "id"
        self.emptyView.addButton(id: id, message: "message")
        let otherId = "otherId"
        self.emptyView.addButton(id: otherId, message: "message")

        let addedButton = self.emptyView.buttons[id]!
        let otherAddedButton = self.emptyView.buttons[otherId]!
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.contains(addedButton))
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.contains(otherAddedButton))
    }

    func test_addAndRemoveButton_expectButtonRemoved() {
        let id = "id"
        self.emptyView.addButton(id: id, message: "message")
        self.emptyView.removeButton(id: id)

        XCTAssertNil(self.emptyView.buttons[id])
        XCTAssertTrue(self.emptyView.buttonsContainer.arrangedSubviews.isEmpty)
    }

    func test_removeButton_buttonNotAdded_expectOk() {
        self.emptyView.removeButton(id: "foo")
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
        self.emptyView.config = config

        self.emptyView.title = "title"
        self.emptyView.message = "message"
        self.emptyView.addButton(id: "id", message: "message")

        wait(for: [expectCustomizeTitleLabel, expectCustomizeMessageLabel, expectCustomizeButtonLabel], timeout: TestUtil.timeoutDefault)

        XCTAssertEqual(self.emptyView.titleLabel?.textColor, changedTextColor)
        XCTAssertEqual(self.emptyView.messageLabel?.textColor, changedTextColor)
        XCTAssertEqual(self.emptyView.buttons["id"]?.titleLabel?.textColor, changedTextColor)
    }
    
}
