//
//  UserService.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

final class UserService {
  class func profile(completion: @escaping DoubleParameterClosure<User?, APIError?>) {
    let request = JSONNetworkRequest(
      baseUrl: Path.baseURL,
      path: Path.profile,
      method: .get,
      completion: completion)
    
    NetworkManager.add(request: request)
  }
  
  class func update(parameters: UserParameters, completion: @escaping DoubleParameterClosure<User?, APIError?>) {
    let request = JSONNetworkRequest(
      baseUrl: Path.baseURL,
      path: Path.updateProfile,
      method: .patch,
      parameters: parameters.params(),
      completion: completion)
    
    NetworkManager.add(request: request)
  }
  
  class func days(completion: @escaping DoubleParameterClosure<UsedDays?, APIError?>) {
    let request = JSONNetworkRequest(
      baseUrl: Path.baseURL,
      path: Path.days,
      method: .get,
      completion: completion)
    
    NetworkManager.add(request: request)
  }
  
  class func organization(completion: @escaping DoubleParameterClosure<Organization?, APIError?>) {
    let request = JSONNetworkRequest(
      baseUrl: Path.baseURL,
      path: Path.organization,
      method: .get,
      completion: completion)
    
    NetworkManager.add(request: request)
  }
}

extension UserService {
  enum Parameters: String {
    case address
    case degree
    case email
    case phone = "phone_number"
  }
}

struct UserParameters {
  var address: String?
  var degree: String?
  var email: String?
  var phone: String?
}

extension UserParameters {
  func params() -> [String: Any] {
    var params = [String: Any]()
    
    if let address = address {params[UserService.Parameters.address.rawValue] = address}
    if let degree = degree {params[UserService.Parameters.degree.rawValue] = degree}
    if let email = email {params[UserService.Parameters.email.rawValue] = email}
    if let phone = phone {params[UserService.Parameters.phone.rawValue] = phone}
    
    return params
  }
}
