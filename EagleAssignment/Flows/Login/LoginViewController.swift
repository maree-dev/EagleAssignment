//
//  LoginViewController.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import UIKit

final class LoginViewController: UIViewController {
  // MARK: - Flows
  var onSuccess: SingleParameterClosure<User>?
  var onError: SingleParameterClosure<APIError>?
  
  // MARK: - Properties
  private let state = LoginState()
  private let behaviour = LoginConcreteBehaviour(resolver: AuthenticationResolver())
  
  // MARK: - ViewLifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    behaviour.setup(state)
    bindActions()
    
    behaviour.set(email: "marko@test.net")
    behaviour.set(password: "testerko")
    behaviour.login()
  }
  
  // MARK: - Private Methods
  private func bindActions() {
    behaviour.onError = {[weak self] in self?.onError?($0)}
    behaviour.onLogin = {[weak self] in self?.onSuccess?($0)}
  }
}
