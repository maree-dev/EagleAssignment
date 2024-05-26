//
//  Strings.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

struct Strings {
  struct Tab {
    static let firstItem = "Organization"
    static let secondItem = "Used Days"
    static let thirdItem = "My Info"
  }
  
  struct Login {
    static let heading = "HR Application"
    static let emailPlaceholder = "Email"
    static let passwordPlaceholder = "Password"
    static let emailError = "Please enter a valid email address."
    static let passwordError = "Please enter a valid password."
    static let ctaTitle = "Login"
  }
  
  struct UsedDays {
    static let personalExcuse = "Personal excuse"
    static let businessAbsence = "Absence due to business"
    static let paidTimeOff = "Paid time off"
    static let sickDays = "Sick days"
    static let workFromHome = "Work from home"
    static let patronSaintDay = "Patron saint day"
  }
}
