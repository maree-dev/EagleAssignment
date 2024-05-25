//
//  UsedDaysResolver.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

protocol UsedDaysResolver {
  func resolver(completion: DoubleParameterClosure<[String]?, APIError?>)
}
