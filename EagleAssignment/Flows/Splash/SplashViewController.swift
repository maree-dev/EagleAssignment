//
//  SplashViewController.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import UIKit

final class SplashViewController: UIViewController {
  // MARK: - Flows
  var onSuccess: VoidClosure?
  var onFail: VoidClosure?
  
  // MARK: - Properties
  private let behaviour = SplashConcreteBehaviour()
  
  // MARK: - View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bindActions()
    behaviour.authenticate()
  }
  
  // MARK: - Private Methods
  private func bindActions() {
    behaviour.onSuccess = {[weak self] in self?.onSuccess?()}
    behaviour.onFail = {[weak self] in self?.onFail?()}
  }
}
