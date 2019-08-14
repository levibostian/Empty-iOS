import Foundation
import UIKit

/// Configuration for `EmptyView`
public class EmptyViewConfig {
    /// Singleton access to `EmptyViewConfig`.
    public static var shared: EmptyViewConfig = EmptyViewConfig()

    /// Initialize new instance of `EmptyViewConfig`
    public init() {}

    /// Customize the title `UILabel` of `EmptyView`. Called when adding a title to `EmptyView` instances.
    public var newTitleLabel: () -> UILabel = {
        EmptyViewConfig.defaultTitleLabel
    }

    /// The default title label for `EmptyView`.
    public static var defaultTitleLabel: UILabel {
        let view = UILabel()
        view.textColor = .darkText
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont.boldSystemFont(ofSize: 24)
        return view
    }

    /// Customize the message `UILabel` of `EmptyView`. Called when adding a message to `EmptyView` instances.
    public var newMessageLabel: () -> UILabel = {
        EmptyViewConfig.defaultMessageLabel
    }

    /// The default message label for `EmptyView`.
    public static var defaultMessageLabel: UILabel {
        let view = UILabel()
        view.textColor = .darkText
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = view.font.withSize(18)
        return view
    }

    /// Customize the `UIButton` of `EmptyView`. Called when adding a button to `EmptyView` instances.
    public var newButton: () -> UIButton = {
        EmptyViewConfig.defaultButton
    }

    /// The default button for `EmptyView`.
    public static var defaultButton: UIButton {
        let view = UIButton()
        view.setTitleColor(.darkGray, for: .normal)
        return view
    }

    /// Set the padding for the leading and trailing side of the contents of `EmptyView`.
    public var viewPadding: CGFloat = 20.0
}
