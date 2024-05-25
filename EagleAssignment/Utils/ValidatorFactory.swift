//
//  ValidatorFactory.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

enum ValidatorType {
  case email(String)
  case password(String)
}

protocol Validator {
  func validate() -> Bool
}

final class ValidatorFactory {
  class func validator(for type: ValidatorType) -> Validator {
    switch type {
    case .email(let value):
      return EmailValidator(email: value)
    case .password(let value):
      return PasswordValidator(password: value)
    }
  }
}

private struct PasswordValidator: Validator {
  var password: String
  
  func validate() -> Bool {
    password.count >= 8
  }
}

private struct EmailValidator: Validator {
  var email: String
  
  func validate() -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
    return predicate.evaluate(with: email)
  }
}
