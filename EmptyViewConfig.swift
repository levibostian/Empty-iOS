//
//  EmptyViewConfig.swift
//  Empty
//
//  Created by Levi Bostian on 8/14/19.
//

import Foundation
import UIKit

/// Configuration for `EmptyView`
public class EmptyViewConfig {
    /// Singleton access to `EmptyViewConfig`.
    public static var shared: EmptyViewConfig = EmptyViewConfig.dark

    /// Initialize new instance of `EmptyViewConfig`
    public init() {}

    internal var newTitleLabel: UILabel {
        let view = UILabel()
        view.textColor = .darkText
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont.boldSystemFont(ofSize: 24)

        customizeTitleLabel?(view)

        return view
    }

    /// Customize the default `UILabel` instance. Called when adding a title to `EmptyView` instances.
    public var customizeTitleLabel: ((UILabel) -> Void)?

    internal var newMessageLabel: UILabel {
        let view = UILabel()
        view.textColor = .darkText
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = view.font.withSize(18)

        customizeMessageLabel?(view)

        return view
    }

    /// Customize the default `UILabel` instance. Called when adding a message to `EmptyView` instances.
    public var customizeMessageLabel: ((UILabel) -> Void)?

    internal var newButton: UIButton {
        let view = UIButton()
        view.setTitleColor(.darkGray, for: .normal)

        customizeButton?(view)

        return view
    }

    /// Customize the default `UIButton` instance. Called when adding a button to `EmptyView` instances.
    public var customizeButton: ((UIButton) -> Void)?

    /// Set the padding for the leading and trailing side of the contents of `EmptyView`.
    public var viewPadding: CGFloat = 20.0
}

public extension EmptyViewConfig {
    /// Convenient `EmptyViewConfig` instance with `UIView`s that are dark in color. Great for light colored backgrounds.
    static let dark: EmptyViewConfig = {
        let config = EmptyViewConfig()
        config.customizeTitleLabel = { uiLabel in
            uiLabel.textColor = .darkText
        }
        config.customizeMessageLabel = { uiLabel in
            uiLabel.textColor = .darkText
        }
        config.customizeButton = { button in
            button.setTitleColor(.darkGray, for: .normal)
        }
        return config
    }()

    /// Convenient `EmptyViewConfig` instance with `UIView`s that are light in color. Great for dark colored backgrounds.
    static let light: EmptyViewConfig = {
        let config = EmptyViewConfig()
        config.customizeTitleLabel = { uiLabel in
            uiLabel.textColor = .white
        }
        config.customizeMessageLabel = { uiLabel in
            uiLabel.textColor = .white
        }
        config.customizeButton = { button in
            button.setTitleColor(.lightGray, for: .normal)
        }
        return config
    }()
}
