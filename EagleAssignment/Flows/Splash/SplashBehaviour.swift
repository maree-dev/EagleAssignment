//
//  SplashBehaviour.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

protocol SplashBehaviour {
  func login()
}

final class SplashConcreteBehaviour {
  var onLogin: SingleParameterClosure<User>?
  var onError: VoidClosure?
  
  private let resolver: LoginResolver
  
  init(resolver: LoginResolver,
       onLogin: SingleParameterClosure<User>? = nil,
       onError: VoidClosure? = nil) {
    
    self.resolver = resolver
    self.onLogin = onLogin
    self.onError = onError
  }
}

extension SplashConcreteBehaviour: SplashBehaviour {
  func login() {}
}
