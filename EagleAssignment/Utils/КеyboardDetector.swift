//
//  КеyboardDetector.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

typealias KeyboardHeight = CGFloat
typealias KeyboardAnimationDuration = NSNumber

class KeyboardDetector {
  var onKeyboardWillAppear: SingleParameterClosure<KeyboardHeight>?
  var onKeyboardWillDisappear: SingleParameterClosure<KeyboardHeight>?
  
  init() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let bottomSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
//      let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
      let height = keyboardFrame.cgRectValue.height
      onKeyboardWillAppear?(height - bottomSafeArea)
    }
  }
     
  @objc func keyboardWillHide(_ notification: Notification) {
    onKeyboardWillDisappear?(.zero)
  }
}
