import Foundation

/// Create a set of default views to conveniently set config for `EmptyView`.
public protocol EmptyViewConfigPreset {
    /// The title `UILabel` instance for the present.
    var titleLabel: UILabel { get }
    /// The message `UILabel` instance for the present.
    var messageLabel: UILabel { get }
    /// The `UIButton` instance for the present.
    var button: UIButton { get }
}

public extension EmptyViewConfigPreset {
    /// Get a `EmptyViewConfig` instance that uses values from `EmptyViewConfigPreset`.
    var config: EmptyViewConfig {
        let config = EmptyViewConfig()
        config.newTitleLabel = { self.titleLabel }
        config.newMessageLabel = { self.messageLabel }
        config.newButton = { self.button }
        return config
    }
}

/// Convenient set of `UIView`s that are dark in color. Great for light colored backgrounds.
public struct DarkEmptyViewConfig: EmptyViewConfigPreset {
    /// Dark colored title label.
    public var titleLabel: UILabel {
        let label = EmptyViewConfig.defaultTitleLabel
        label.textColor = .darkText
        return label
    }

    /// Dark colored message label.
    public var messageLabel: UILabel {
        let label = EmptyViewConfig.defaultMessageLabel
        label.textColor = .darkText
        return label
    }

    /// Dark colored button.
    public var button: UIButton {
        let label = EmptyViewConfig.defaultButton
        label.setTitleColor(.darkGray, for: .normal)
        return label
    }
}

/// Convenient set of `UIView`s that are light in color. Great for dark colored backgrounds.
public struct LightEmptyViewConfig: EmptyViewConfigPreset {
    /// Light colored title label.
    public var titleLabel: UILabel {
        let label = EmptyViewConfig.defaultTitleLabel
        label.textColor = .white
        return label
    }

    /// Light colored message label.
    public var messageLabel: UILabel {
        let label = EmptyViewConfig.defaultMessageLabel
        label.textColor = .white
        return label
    }

    /// Light colored button.
    public var button: UIButton {
        let label = EmptyViewConfig.defaultButton
        label.setTitleColor(.lightGray, for: .normal)
        return label
    }
}

public extension EmptyViewConfig {
    /// Convenient access to `DarkEmptyViewConfig`.
    static let darkPresent: EmptyViewConfigPreset = DarkEmptyViewConfig()

    /// Convenient access to `LightEmptyViewConfig`.
    static let light: EmptyViewConfigPreset = LightEmptyViewConfig()
}
