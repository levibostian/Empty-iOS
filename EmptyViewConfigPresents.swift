//
//  EmptyViewConfigPresents.swift
//  Empty
//
//  Created by Levi Bostian on 8/14/19.
//

import Foundation

public protocol EmptyViewConfigPreset {
    var titleLabel: UILabel { get }
    var messageLabel: UILabel { get }
    var button: UIButton { get }
}

public struct DarkEmptyViewConfig: EmptyViewConfigPreset {
    public var titleLabel: UILabel {
        let label = EmptyViewConfig.defaultTitleLabel
        label.textColor = .darkText
        return label
    }
    public var messageLabel: UILabel {
        let label = EmptyViewConfig.defaultMessageLabel
        label.textColor = .darkText
        return label
    }
    public var button: UIButton {
        let label = EmptyViewConfig.defaultButton
        label.setTitleColor(.darkGray, for: .normal)
        return label
    }
}

public struct LightEmptyViewConfig: EmptyViewConfigPreset {
    public var titleLabel: UILabel {
        let label = EmptyViewConfig.defaultTitleLabel
        label.textColor = .white
        return label
    }
    public var messageLabel: UILabel {
        let label = EmptyViewConfig.defaultMessageLabel
        label.textColor = .white
        return label
    }
    public var button: UIButton {
        let label = EmptyViewConfig.defaultButton
        label.setTitleColor(.lightGray, for: .normal)
        return label
    }
}

public extension EmptyViewConfig {
    /// Convenient `EmptyViewConfig` instance with `UIView`s that are dark in color. Great for light colored backgrounds.
    static let darkPresent: EmptyViewConfigPreset = DarkEmptyViewConfig()

    /// Convenient `EmptyViewConfig` instance with `UIView`s that are light in color. Great for dark colored backgrounds.
    static let light: EmptyViewConfigPreset = LightEmptyViewConfig()
}
