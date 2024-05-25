//
//  ValidatorTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import XCTest

final class ValidatorTests: XCTestCase {
  func testEmailValidator() {
    XCTAssertFalse(ValidatorFactory.validator(for: .email("")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .email("test")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .email("test.net")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .email("test@.net")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .email("test@test")).validate())
    
    XCTAssertTrue(ValidatorFactory.validator(for: .email("test@test.net")).validate())
    XCTAssertTrue(ValidatorFactory.validator(for: .email("test@gmail.com")).validate())
  }
  
  func testPasswordValidator() {
    XCTAssertFalse(ValidatorFactory.validator(for: .password("")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .password("t")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .password("te")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .password("tes")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .password("test")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .password("teste")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .password("tester")).validate())
    XCTAssertFalse(ValidatorFactory.validator(for: .password("testerk")).validate())
    
    XCTAssertTrue(ValidatorFactory.validator(for: .password("testerko")).validate())
  }
}
