//
//  UsedDaysAdapterTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import XCTest

final class UsedDaysAdapterTests: XCTestCase {
  
  func testAdapter() {
    let days = Days(personalExcuse: 0, absenceDueToBusiness: 20, paidTimeOff: 22, sickDays: 3, workFromHome: 6, patronSaintDay: 1)
    let result = UsedDaysAdapter(days: [days]).convert()
    
    XCTAssertEqual(result.count, 6)
    XCTAssertEqual(result[0].infoCardTitle, "Personal excuse")
    XCTAssertEqual(result[0].infoCardSubtitle, "0")
    
    XCTAssertEqual(result[1].infoCardTitle, "Absence due to business")
    XCTAssertEqual(result[1].infoCardSubtitle, "20")
    
    XCTAssertEqual(result[2].infoCardTitle, "Paid time off")
    XCTAssertEqual(result[2].infoCardSubtitle, "22")
    
    XCTAssertEqual(result[3].infoCardTitle, "Sick days")
    XCTAssertEqual(result[3].infoCardSubtitle, "3")
    
    XCTAssertEqual(result[4].infoCardTitle, "Work from home")
    XCTAssertEqual(result[4].infoCardSubtitle, "6")
    
    XCTAssertEqual(result[5].infoCardTitle, "Patron saint day")
    XCTAssertEqual(result[5].infoCardSubtitle, "1")
  }
}
