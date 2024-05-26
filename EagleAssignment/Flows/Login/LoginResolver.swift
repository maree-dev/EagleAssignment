//
//  LoginResolver.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

protocol LoginResolver {
  func resolve(parameters: AuthParameters?, completion: @escaping DoubleParameterClosure<User?, APIError?>)
}

final class AuthenticationResolver: LoginResolver {
  func resolve(parameters: AuthParameters?, completion: @escaping DoubleParameterClosure<User?, APIError?>) {
    guard let parameters = parameters else {return completion(nil,nil)}
    
    AuthenticationService.obtainAccessToken(parameters: parameters) {(token, error) in
      NetworkManager.shared.token = token
      UserService.profile { user, error in
        completion(user, error)
      }
    }
  }
}
