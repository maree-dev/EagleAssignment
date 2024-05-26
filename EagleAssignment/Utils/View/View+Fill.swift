//
//  View+Fill.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit
import TinyConstraints

extension UIView {
  func fill(with view: UIView, insets: UIEdgeInsets = .zero) {
    addSubview(view)
    view.edgesToSuperview(insets: insets)
  }
}
