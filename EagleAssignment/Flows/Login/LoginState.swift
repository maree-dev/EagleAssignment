//
//  LoginState.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

final class LoginState {
  var email: String
  var emailError: String?
  
  var password: String
  var passwordError: String?
  
  var isLoading: Bool
  
  init(email: String = "",
       password: String = "",
       emailError: String? = nil,
       passwordError: String? = nil,
       isLoading: Bool = false) {
    
    self.email = email
    self.password = password
    self.emailError = emailError
    self.passwordError = passwordError
    self.isLoading = isLoading
  }
}
