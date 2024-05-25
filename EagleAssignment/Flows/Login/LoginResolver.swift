//
//  LoginResolver.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

protocol LoginResolver {
  func resolve(completion: DoubleParameterClosure<User?, APIError?>)
}
