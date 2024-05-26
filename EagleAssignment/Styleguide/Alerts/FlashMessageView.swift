//
//  FlashMessageView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class FlashMessageView: UIView {
  // MARK: - Outlets
  @IBOutlet weak var labelMessage: UILabel!
  
  var message: String? {
    didSet {labelMessage.text = message}
  }
  
  // MARK: - View lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.cornerRadius = 4
    setupSwipeGesture()
  }
  
  // MARK: - Public methods
  func show(in view: UIView) {
    transform = CGAffineTransform(translationX: 0, y: -(bounds.height * 1.5 + safeArea().top))
    alpha = 0
    
    view.addSubview(self)
    self.edgesToSuperview(excluding: .bottom, insets: UIEdgeInsets(top: safeArea().top+16, left: 24, bottom: 0, right: 24))
    
    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) { [weak self] in
      self?.transform = .identity
      self?.alpha = 1
    } completion: { [weak self] _ in
      DispatchQueue.main.asyncAfter(deadline: .now()+5) { [weak self] in
        self?.dismiss()
      }
    }
  }
  
  func dismiss() {
    UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut) { [weak self] in
      self?.transform = CGAffineTransform(translationX: 0, y: -((self?.bounds.height ?? 0) * 1.5 + safeArea().top))
      self?.alpha = 0
    } completion: { [weak self] _ in
      self?.removeFromSuperview()
    }
  }
  
  // MARK: - Private methods
  private func setupSwipeGesture() {
    let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    swipe.direction = .up
    addGestureRecognizer(swipe)
  }
  
  @objc private func handleSwipe(_ sender: UIGestureRecognizer) {
    guard sender.state == .recognized else {return}
    dismiss()
  }
}
