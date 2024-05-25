//
//  Days.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

struct Days: Decodable {
  var personalExcuse: Int?
  var absenceDueToBusiness: Int?
  var paidTimeOff: Int?
  var sickDays: Int?
  var workFromHome: Int?
  var patronSaintDay: Int?
}

extension Days {
  enum CodingKeys: String, CodingKey {
    case personalExcuse = "personal_excuse"
    case absenceDueToBusiness = "absence_due_to_business"
    case paidTimeOff = "paid_time_off"
    case sickDays = "sick_days"
    case workFromHome = "work_from_home"
    case patronSaintDay = "patron_saint_day"
  }
}
