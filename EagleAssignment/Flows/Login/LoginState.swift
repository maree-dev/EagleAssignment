//
//  LoginState.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

final class LoginState {
  var email: String
  var password: String
  var isLoading: Bool
  
  init(email: String = "",
       password: String = "",
       isLoading: Bool = false) {
    
    self.email = email
    self.password = password
    self.isLoading = isLoading
  }
}
