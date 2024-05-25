//
//  LoginBehaviour.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

protocol LoginBehaviour {
  func setup(_ state: LoginState)
  func set(email: String)
  func set(password: String)
  func login()
}

final class LoginConcreteBehaviour {
  var onLogin: SingleParameterClosure<User>?
  var onError: SingleParameterClosure<APIError>?
  
  private let resolver: LoginResolver
  private weak var state: LoginState!
  
  init(resolver: LoginResolver,
       onLogin: SingleParameterClosure<User>? = nil,
       onError: SingleParameterClosure<APIError>? = nil) {
    
    self.resolver = resolver
    self.onLogin = onLogin
    self.onError = onError
  }
  
  private func validateInputs() -> Bool {
    let email = ValidatorFactory.validator(for: .email(state.email))
    let password = ValidatorFactory.validator(for: .password(state.password))
    
    return email.validate() && password.validate()
  }
}

extension LoginConcreteBehaviour: LoginBehaviour {
  func setup(_ state: LoginState) {
    self.state = state
  }
  
  func set(email: String) {
    state.email = email
  }
  
  func set(password: String) {
    state.password = password
  }
  
  func login() {
    guard validateInputs() else {return}
    
    let params = AuthParameters(email: state.email, password: state.password)
    state.isLoading = true
    
    resolver.resolve(parameters: params) {[weak self] (user, error) in
      self?.state.isLoading = false
      
      if let user = user {self?.onLogin?(user)}
      else {self?.onError?(error ?? .generic)}
    }
  }
}
