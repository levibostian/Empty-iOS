//
//  UIViewExtension.swift
//  Empty
//
//  Created by Levi Bostian on 8/14/19.
//

import Foundation
import UIKit

internal extension UIView {
    func removeAllSubviews() {
        subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
}
