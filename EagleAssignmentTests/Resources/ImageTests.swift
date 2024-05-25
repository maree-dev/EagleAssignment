//
//  ImageTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import XCTest

final class ImageTests: XCTestCase {
  func testImages() {
    XCTAssertNotNil(UIImage.building)
    XCTAssertNotNil(UIImage.buildingFill)
    XCTAssertNotNil(UIImage.list)
    XCTAssertNotNil(UIImage.listFill)
    XCTAssertNotNil(UIImage.person)
    XCTAssertNotNil(UIImage.personFill)
  }
}
