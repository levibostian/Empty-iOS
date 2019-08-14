import Foundation
import UIKit

internal extension UIStackView {
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { subview in
            self.completelyRemoveArrangedSubview(subview)
        }
    }

    func completelyRemoveArrangedSubview(_ view: UIView?) {
        guard let view = view else {
            return
        }

        if arrangedSubviews.contains(view) {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
