//
//  View+Instance.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

extension UIView {
  class func instance<T: UIView>() -> T? {
    return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T
  }
}
