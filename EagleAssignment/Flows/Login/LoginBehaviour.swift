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
  
  init(resolver: LoginResolver,
       onLogin: SingleParameterClosure<User>? = nil,
       onError: SingleParameterClosure<APIError>? = nil) {
    
    self.resolver = resolver
    self.onLogin = onLogin
    self.onError = onError
  }
}

extension LoginConcreteBehaviour: LoginBehaviour {
  func setup(_ state: LoginState) {}
  func set(email: String) {}
  func set(password: String) {}
  func login() {}
}
