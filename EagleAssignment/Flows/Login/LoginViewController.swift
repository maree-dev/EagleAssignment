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
  
  // MARK: - Outlets
  @IBOutlet weak var viewContent: UIView!
  @IBOutlet weak var viewCTA: UIView!
  private let form: LoginFormView = .instance()!
  private let cta: CTAView = .instance(title: Strings.Login.ctaTitle)!
  
  // MARK: - Properties
  private let state = LoginState()
  private let behaviour = LoginConcreteBehaviour(resolver: AuthenticationResolver())
  
  // MARK: - ViewLifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    behaviour.setup(state)
    bindActions()
    setupView()
  }
  
  // MARK: - Private Methods
  private func bindActions() {
    behaviour.onError = {[weak self] in self?.onError?($0)}
    behaviour.onLogin = {[weak self] in self?.onSuccess?($0)}
    behaviour.onChange = {[weak self] in self?.render()}
    
    form.emailField.onEdit = {[weak self] in self?.behaviour.set(email: $0)}
    form.passwordField.onEdit = {[weak self] in self?.behaviour.set(password: $0)}
    cta.onTap = {[weak self] in self?.behaviour.login()}
  }
  
  private func setupView() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    viewContent.fill(with: form)
    viewCTA.fill(with: cta)
  }
  
  private func render() {
    form.emailField.error = state.emailError
    form.passwordField.error = state.passwordError
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
}
