//
//  User.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import Foundation

struct User: Decodable {
  var id: Int?
  var email: String?
  var firstName: String?
  var lastName: String?
  var address: String?
  var phone: String?
  var degree: String?
}

extension User {
  enum CodingKeys: String, CodingKey {
    case id, email, address, degree
    case firstName = "first_name"
    case lastName = "last_name"
    case phone = "phone_number"
  }
}
