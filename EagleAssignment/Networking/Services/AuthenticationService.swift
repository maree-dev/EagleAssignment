//
//  AuthenticationService.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

final class AuthenticationService {
  class func obtainAccessToken(parameters: AuthParameters, completion: @escaping DoubleParameterClosure<AccessToken? , APIError?>) {
    let request = JSONNetworkRequest(
      baseUrl: Path.baseURL,
      path: Path.login,
      method: .post,
      parameters: parameters.params(),
      completion: completion)
    
    NetworkManager.add(request: request)
  }
}

extension AuthenticationService {
  enum Parameter: String {
    case email
    case password
  }
}

struct AuthParameters {
  var email: String?
  var password: String?
}

extension AuthParameters {
  func params() -> [String: Any] {
    var params = [String: Any]()
    
    if let email = email {params[AuthenticationService.Parameter.email.rawValue] = email}
    if let password = password {params[AuthenticationService.Parameter.password.rawValue] = password}
    
    return params
  }
}
