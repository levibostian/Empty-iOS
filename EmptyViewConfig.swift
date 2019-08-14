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
    public static var shared: EmptyViewConfig = EmptyViewConfig()

    /// Initialize new instance of `EmptyViewConfig`
    public init() {}

    /// Customize the `UILabel` of `EmptyView`. Called when adding a title to `EmptyView` instances.
    public var newTitleLabel: () -> UILabel = {
        return EmptyViewConfig.defaultTitleLabel
    }

    public static var defaultTitleLabel: UILabel {
        let view = UILabel()
        view.textColor = .darkText
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont.boldSystemFont(ofSize: 24)
        return view
    }

    public var newMessageLabel: () -> UILabel = {
        return EmptyViewConfig.defaultMessageLabel
    }

    public static var defaultMessageLabel: UILabel {
        let view = UILabel()
        view.textColor = .darkText
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = view.font.withSize(18)
        return view
    }

    public var newButton: () -> UIButton = {
        return EmptyViewConfig.defaultButton
    }

    public static var defaultButton: UIButton {
        let view = UIButton()
        view.setTitleColor(.darkGray, for: .normal)
        return view
    }

    /// Set the padding for the leading and trailing side of the contents of `EmptyView`.
    public var viewPadding: CGFloat = 20.0
}
