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
  var onError: SingleParameterClosure<APIError>?
  var onLogin: VoidClosure?
  var onChange: VoidClosure?
  
  private let resolver: LoginResolver
  private weak var state: LoginState!
  
  init(resolver: LoginResolver,
       onLogin: VoidClosure? = nil,
       onError: SingleParameterClosure<APIError>? = nil) {
    
    self.resolver = resolver
    self.onLogin = onLogin
    self.onError = onError
  }
  
  private func validateInputs() -> Bool {
    let isEmailValid = ValidatorFactory.validator(for: .email(state.email)).validate()
    let isPasswordValid = ValidatorFactory.validator(for: .password(state.password)).validate()
    
    state.emailError = isEmailValid ? nil : Strings.Login.emailError
    state.passwordError = isPasswordValid ? nil : Strings.Login.passwordError
    onChange?()

    return isEmailValid && isPasswordValid
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
    onChange?()
    
    resolver.resolve(parameters: params) {[weak self] (_, error) in
      DispatchQueue.main.async {
        self?.state.isLoading = false
        self?.onChange?()
        
        if let error = error {self?.onError?(error)}
        else {self?.onLogin?()}
      }
    }
  }
}
