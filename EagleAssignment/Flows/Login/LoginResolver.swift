//
//  LoginResolver.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

protocol LoginResolver {
  func resolve(parameters: AuthParameters?, completion: @escaping DoubleParameterClosure<AccessToken?, APIError?>)
}

final class AuthenticationResolver: LoginResolver {
  func resolve(parameters: AuthParameters?, completion: @escaping DoubleParameterClosure<AccessToken?, APIError?>) {
    guard let parameters = parameters else {return completion(nil, .generic)}
    
    AuthenticationService.obtainAccessToken(parameters: parameters) { token, error in
      guard let token = token else {return completion(token, error)}
      TokenStorage.store(token)
      NetworkManager.shared.token = token
      completion(token, error)
    }
  }
}
