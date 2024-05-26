//
//  MyInfoState.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import Foundation

final class MyInfoState {
  var firstName: String?
  var lastName: String?
  var dateOfBirth: String?
  var hireDate: String?
  var address: String?
  var degree: String?
  var phone: String?
  var email: String?
  var emailError: String?
  var isLoading: Bool
  
  init(firstName: String? = nil,
       lastName: String? = nil,
       dateOfBirth: String? = nil,
       hireDate: String? = nil,
       address: String? = nil,
       degree: String? = nil,
       phone: String? = nil,
       email: String? = nil,
       emailError: String? = nil,
       isLoading: Bool = false) {
    
    self.firstName = firstName
    self.lastName = lastName
    self.dateOfBirth = dateOfBirth
    self.hireDate = hireDate
    self.address = address
    self.degree = degree
    self.phone = phone
    self.email = email
    self.emailError = emailError
    self.isLoading = isLoading
  }
}
