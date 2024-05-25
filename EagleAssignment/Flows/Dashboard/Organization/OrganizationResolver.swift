//
//  OrganizationResolver.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

protocol OrganizationResolver {
  func resolver(completion: DoubleParameterClosure<[String]?, APIError?>)
}
