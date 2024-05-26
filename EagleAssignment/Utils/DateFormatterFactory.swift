//
//  DateFormatterFactory.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 27.05.2024.
//

import Foundation

enum DateFormat: String {
  case short = "dd/MM/yyyy"
  case shortUTC = "yyyy-MM-dd"
  case shortWithTime = "dd/MM/yyyy, h:mm a"
  case time = "h:mm a"
  case utc = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
  case day = "EEE, MMM dd"
  case dayLong = "EEEE, MMMM dd"
  case dayAndMonth = "dd MMM"
  case dayMonth = "dd/MM"
  case monthAndYear = "MMMM yyyy"
  case fullMonthName = "dd MMM, yyyy"
  case fullMonthNameNoComma = "dd MMMM yyyy"
  case dayOfWeek = "EEEE"
  case mediumMonthDayYear = "MMM dd, yyyy"
}

class DateFormatterFactory {
  class func string(from date: Date?, format: DateFormat) -> String {
    guard let date = date else {return ""}
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    return formatter.string(from: date)
  }
  
  class func date(from string: String, format: DateFormat) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    return formatter.date(from: string)
  }
}
