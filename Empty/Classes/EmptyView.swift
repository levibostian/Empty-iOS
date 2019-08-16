import Foundation
import UIKit

/// Delegate for `EmptyView`.
public protocol EmptyViewDelegate: AnyObject {
    /// Button that was added to `EmptyView` has been pressed.
    func buttonPressed(id: EmptyViewButtonTag)
}

/// Defines typealias for tags when adding buttons to `EmptyView`.
public typealias EmptyViewButtonTag = String

/// Quick and easy UIView to use when you have no data to show. Also great for displaying errors!
public class EmptyView: UIView {
    /// Access to `EmptyViewConfig` to set defaults on all instances of `EmptyView`.
    public static let defaultConfig: EmptyViewConfig = EmptyViewConfig.shared
    /// Override `defaultConfig` for this once instance.
    public var config: EmptyViewConfig = EmptyView.defaultConfig {
        didSet {
            build()
        }
    }

    /// Set delegate for `EmptyView`.
    public weak var delegate: EmptyViewDelegate?

    /// Read-only reference to the title `UILabel`.
    public private(set) var titleLabel: UILabel?

    /// Read-only reference to the message `UILabel`
    public private(set) var messageLabel: UILabel?

    /// Read-only reference to the `UIButton`s added to `EmptyView`
    public var buttons: [EmptyViewButtonTag: UIButton] {
        var buttonsCollection: [EmptyViewButtonTag: UIButton] = [:]

        buttonIds.forEach { buttonId, buttonViewTag in
            if let button: UIButton = self.buttonsContainer.arrangedSubviews.first(where: { $0 is UIButton && $0.tag == buttonViewTag }) as? UIButton {
                buttonsCollection[buttonId] = button
            }
        }

        return buttonsCollection
    }

    /// Internal use only.
    public let rootView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 18
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()

    /// Internal use only.
    public let labelsContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 12
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()

    /// Internal use only.
    public let buttonsContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 6
        view.translatesAutoresizingMaskIntoConstraints = true
        return view
    }()

    /// Read or change the text of `titleLabel`
    public var title: String? {
        didSet {
            build()
        }
    }

    /// Read or change the text of `messageLabel`
    public var message: String? {
        didSet {
            build()
        }
    }

    private var buttonIds: [EmptyViewButtonTag: Int] = [:]

    /**
     * Add a `UIButton` to the `EmptyView`.
     * Note: If there is already a `UIView` with given `id`, that view will be removed before the new `UIButton` is added.
     */
    public func addButton(id: EmptyViewButtonTag, message: String) {
        removeButton(id: id)

        let button = config.newButton()
        let buttonTag = buttonIds.keys.count + 1
        button.tag = buttonTag
        button.setTitle(message, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        buttonsContainer.addArrangedSubview(button)
        buttonIds[id] = buttonTag
    }

    /// Remove a previously added `UIButton`.
    public func removeButton(id: EmptyViewButtonTag) {
        guard let button = self.buttons[id] else {
            return
        }

        buttonsContainer.removeArrangedSubview(button)
        buttonIds.removeValue(forKey: id)
    }

    /// Remove all views from `EmptyView` to start over.
    public func resetViews() {
        title = nil
        message = nil
        labelsContainer.removeAllArrangedSubviews()
        buttonsContainer.removeAllArrangedSubviews()
        removeAllSubviews()

        build()
    }

    /// Internal use only. Set `delegate` to receive notifications when buttons are pressed.
    @objc func buttonPressed(sender: UIButton) {
        guard let index = buttonIds.values.firstIndex(where: { $0 == sender.tag }) else {
            return
        }

        let buttonId = buttonIds[index].key
        delegate?.buttonPressed(id: buttonId)
    }

    /// Initialize new instance of `EmptyView`.
    public convenience init() {
        self.init(frame: CGRect.zero)

        build()
    }

    private func build() {
        // Prevent views being added twice. But also, allow the chance to create new views if the customization has changed.
        labelsContainer.removeAllArrangedSubviews()
        titleLabel = nil
        messageLabel = nil

        if title != nil {
            titleLabel = config.newTitleLabel()
            labelsContainer.addArrangedSubview(titleLabel!)
        }
        if message != nil {
            messageLabel = config.newMessageLabel()
            labelsContainer.addArrangedSubview(messageLabel!)
        }

        rootView.addArrangedSubview(labelsContainer)
        rootView.addArrangedSubview(buttonsContainer)
        addSubview(rootView)

        setupConstraints()
        configView()
    }

    /// Internal use only.
    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    private func configView() {
        titleLabel?.text = title
        messageLabel?.text = message
    }

    private func setupConstraints() {
        let superviewMargins = layoutMarginsGuide
        let rootViewPadding = config.viewPadding

        rootView.translatesAutoresizingMaskIntoConstraints = false
        rootView.centerYAnchor.constraint(equalTo: superviewMargins.centerYAnchor).isActive = true
        rootView.leadingAnchor.constraint(equalTo: superviewMargins.leadingAnchor, constant: rootViewPadding).isActive = true
        rootView.trailingAnchor.constraint(equalTo: superviewMargins.trailingAnchor, constant: -rootViewPadding).isActive = true

        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.leadingAnchor.constraint(equalTo: rootView.layoutMarginsGuide.leadingAnchor).isActive = true
        titleLabel?.trailingAnchor.constraint(equalTo: rootView.layoutMarginsGuide.trailingAnchor).isActive = true

        messageLabel?.translatesAutoresizingMaskIntoConstraints = false
        messageLabel?.leadingAnchor.constraint(equalTo: rootView.layoutMarginsGuide.leadingAnchor).isActive = true
        messageLabel?.trailingAnchor.constraint(equalTo: rootView.layoutMarginsGuide.trailingAnchor).isActive = true

        updateConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
