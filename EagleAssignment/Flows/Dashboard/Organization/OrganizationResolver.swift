//
//  OrganizationResolver.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

protocol OrganizationResolver {
  func resolve(completion: @escaping DoubleParameterClosure<[User]?, APIError?>)
}

final class OrganizationConcreteResolver: OrganizationResolver {
  func resolve(completion: @escaping DoubleParameterClosure<[User]?, APIError?>) {
    UserService.organization { response, error in
      completion(response?.items, error)
    }
  }
}
