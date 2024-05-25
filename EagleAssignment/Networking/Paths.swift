//
//  Paths.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

struct Path {
  /// Base
  static let baseURL = "https://api-assigment.eaglelab.com/v1"
  
  /// General
  static let login = "/login"
  static let organization = "/users"
  
  /// User
  static let profile = "/users/profile"
  static let updateProfile = "/users/{id}"
  static let days = "/usage"
}
