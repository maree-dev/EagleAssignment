//
//  UsedDaysAdapter.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import Foundation

final class UsedDaysAdapter {
  private let days: [Days]
  
  init(days: [Days]) {
    self.days = days
  }
  
  func convert() -> [InfoCardDisplayable] {
    guard let days = days.first else {return []}
    
    return [BaseInfoCardDisplayable(
      infoCardTitle: Strings.UsedDays.personalExcuse,
      infoCardSubtitle: String(days.personalExcuse ?? 0)),
     BaseInfoCardDisplayable(
       infoCardTitle: Strings.UsedDays.businessAbsence,
       infoCardSubtitle: String(days.absenceDueToBusiness ?? 0)),
     BaseInfoCardDisplayable(
       infoCardTitle: Strings.UsedDays.paidTimeOff,
       infoCardSubtitle: String(days.paidTimeOff ?? 0)),
     BaseInfoCardDisplayable(
       infoCardTitle: Strings.UsedDays.sickDays,
       infoCardSubtitle: String(days.sickDays ?? 0)),
     BaseInfoCardDisplayable(
       infoCardTitle: Strings.UsedDays.workFromHome,
       infoCardSubtitle: String(days.workFromHome ?? 0)),
     BaseInfoCardDisplayable(
       infoCardTitle: Strings.UsedDays.patronSaintDay,
       infoCardSubtitle: String(days.patronSaintDay ?? 0)),
    ]
  }
}
