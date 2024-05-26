//
//  OrganizationAdapterTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import XCTest

final class OrganizationAdapterTests: XCTestCase {
  
  func testFull() {
    let user = User(firstName: "Aleksandar", lastName: "Vučić", address: "Trg Nikole Pašića 13", phone: "011 3026100")
    let result = OrganizationAdapter(users: [user]).convert()
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result[0].employeeCardName, "Aleksandar Vučić")
    XCTAssertEqual(result[0].employeeCardAddress, "Trg Nikole Pašića 13")
    XCTAssertEqual(result[0].employeeCardPhone, "011 3026100")
  }
  
  func testPartial() {
    let user = User(firstName: "Aleksandar", lastName: "Vučić", address: "")
    let result = OrganizationAdapter(users: [user]).convert()
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result[0].employeeCardName, "Aleksandar Vučić")
    XCTAssertEqual(result[0].employeeCardAddress, "-")
    XCTAssertEqual(result[0].employeeCardPhone, "-")
  }
}
