//
//  APIError.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

struct APIError: Decodable {
  var message: String?
  var status: Int?
}

extension APIError: LocalizedError {
  public var errorDescription: String? {message}
}

extension APIError {
  static var generic: APIError {
    APIError(message: "Ooops, something went wrong")
  }
  
  static var parse: APIError {
    APIError(message: "Data from API is not matching")
  }
  
  static var unauthenticated: APIError {
    APIError(message: "User session expired")
  }
  
  static var noInternet: APIError {
    APIError(message: "Are you offline? Please retry.")
  }
}
