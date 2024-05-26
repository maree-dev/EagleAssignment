//
//  CTAView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class CTAView: UIView {
  // MARK: - Actions
  var onTap: VoidClosure?
  
  // MARK: - Outlets
  @IBOutlet weak var button: UIButton!
  
  // MARK: - Properties
  var title: String? {
    didSet {button.setTitle(title, for: .normal)}
  }
  
  // MARK: - ViewLifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  // MARK: - Init
  class func instance(title: String) -> CTAView? {
    guard let view: CTAView = .instance() else {return nil}
    view.title = title
    
    return view
  }
  
  // MARK: - Private Methods
  private func setupView() {
    button.backgroundColor = .link
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = Constants.cornerRadius
    button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
  }
  
  @objc private func handleTap() {onTap?()}
}

extension CTAView {
  private struct Constants {
    static let cornerRadius: CGFloat = 4
  }
}
