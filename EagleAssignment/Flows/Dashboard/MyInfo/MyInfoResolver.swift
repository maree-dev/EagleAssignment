//
//  MyInfoResolver.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import Foundation

protocol MyInfoResolver {
  func profile(completion: @escaping DoubleParameterClosure<User?, APIError?>)
  func update(params: UserParameters?, completion: @escaping DoubleParameterClosure<EmptyResponse?, APIError?>)
}

final class MyInfoConcreteResolver: MyInfoResolver {
  func profile(completion: @escaping DoubleParameterClosure<User?, APIError?>) {
    UserService.profile(completion: completion)
  }
  
  func update(params: UserParameters?, completion: @escaping DoubleParameterClosure<EmptyResponse?, APIError?>) {
    // TODO: - Implement
  }
}
