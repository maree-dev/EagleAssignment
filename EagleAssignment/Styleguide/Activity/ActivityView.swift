//
//  ActivityView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class ActivityView: UIView {
  // MARK: - Outlets
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Properties
  weak var container: UIView?
  
  var isActive: Bool = false {
    didSet {isActive ? show() : dismiss()}
  }
  
  // MARK: - ViewLifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  // MARK: - Private methods
  private func setupView() {
    activityIndicator.hidesWhenStopped = true
  }
  
  private func show() {
    activityIndicator.startAnimating()
    container?.fill(with: self)
  }
  
  private func dismiss() {
    activityIndicator.stopAnimating()
    removeFromSuperview()
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    isActive ? self : nil
  }
}
