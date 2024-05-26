//
//  UsedDaysResolver.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

protocol UsedDaysResolver {
  func resolve(completion: @escaping DoubleParameterClosure<[Days]?, APIError?>)
}

final class UsedDaysConcreteResolver: UsedDaysResolver {
  func resolve(completion: @escaping DoubleParameterClosure<[Days]?, APIError?>) {
    UserService.days {completion($0?.items, $1)}
  }
}
