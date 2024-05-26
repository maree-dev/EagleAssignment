//
//  ScallableView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class ScallableView: UIView {
  // MARK: - Actions
  var onPress: VoidClosure?
  var onTouch: VoidClosure?
  
  // MARK: - Properties
  @IBInspectable var scale: CGFloat = 0.95
  @IBInspectable var highlight: UIColor = .clear
  private weak var target: UIView?
  var originalColor: UIColor?
  
  // MARK: - Public Methods
  override func awakeFromNib() {
    super.awakeFromNib()
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
  }
  
  override func addSubview(_ view: UIView) {
    super.addSubview(view)
    originalColor = view.backgroundColor
    target = view
  }
  
  // MARK: - Private Methods
  private func animate(scale: CGFloat, highlight: UIColor?, duration: TimeInterval, completion: VoidClosure? = nil) {
    UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut, .beginFromCurrentState], animations: { [weak self] in
      self?.transform = CGAffineTransform(scaleX: scale, y: scale)
      self?.target?.backgroundColor = highlight
    }, completion: { _ in
      completion?()
    })
  }
  
  @objc func handleTap(_ sender: UIGestureRecognizer) {
    if sender.state == .recognized {
      animate(scale: scale, highlight: highlight, duration: 0.1) { [weak self] in
        self?.animate(scale: 1.0, highlight: self?.originalColor, duration: 0.2) { [weak self] in
          self?.onPress?()
        }
      }
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    animate(scale: scale, highlight: highlight, duration: 0.1)
    super.touchesBegan(touches, with: event)
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    onTouch?()
    animate(scale: 1.0, highlight: originalColor, duration: 0.2) { [weak self] in
      self?.onPress?()
    }
    super.touchesEnded(touches, with: event)
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    animate(scale: 1.0, highlight: originalColor, duration: 0.2)
    super.touchesCancelled(touches, with: event)
  }
}

