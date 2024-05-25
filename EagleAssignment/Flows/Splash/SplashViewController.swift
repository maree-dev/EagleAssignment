//
//  SplashViewController.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import UIKit

final class SplashViewController: UIViewController {
  // MARK: - Flows
  var onFinish: SingleParameterClosure<User>?
  var onError: VoidClosure?
  
  // MARK: - Properties
  private let behaviour = SplashConcreteBehaviour(resolver: AuthenticationResolver())
  
  // MARK: - View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    bindActions()
    behaviour.login()
  }
  
  // MARK: - Private Methods
  private func bindActions() {
    behaviour.onLogin = {[weak self] in self?.onFinish?($0)}
    behaviour.onError = {[weak self] in self?.onError?()}
  }
}
