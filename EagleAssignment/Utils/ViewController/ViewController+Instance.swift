//
//  ViewController+Instance.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import UIKit

extension UIViewController {
  class func instance<T: UIViewController>() -> T? {
    let nibName = String(describing: T.self)
    let bundle = Bundle(for: T.self)
    return T(nibName: nibName, bundle: bundle)
  }
}
