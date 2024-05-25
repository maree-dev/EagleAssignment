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
    completion(nil, nil)
  }
}
