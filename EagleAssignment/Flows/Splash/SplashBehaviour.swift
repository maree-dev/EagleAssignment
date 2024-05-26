//
//  SplashBehaviour.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

protocol SplashBehaviour {
  func authenticate()
}

final class SplashConcreteBehaviour {
  var onSuccess: VoidClosure?
  var onFail: VoidClosure?
  
  init(onSuccess: VoidClosure? = nil,
       onFail: VoidClosure? = nil) {
    
    self.onSuccess = onSuccess
    self.onFail = onFail
  }
}

extension SplashConcreteBehaviour: SplashBehaviour {
  func authenticate() {
    guard let token = TokenStorage.token() else {
      onFail?()
      return
    }
    
    NetworkManager.shared.token = token
    onSuccess?()
  }
}
