//
//  SplashBehaviourTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import XCTest

final class SplashBehaviourTests: XCTestCase {
  func testLoginError() {
    let expectation = XCTestExpectation(description: "Should trigger onError closure")
    let behaviour = SplashConcreteBehaviour(resolver: FakeLoginResolver(), onError: {
      expectation.fulfill()
    })
    behaviour.login()
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
  
  func testLoginSuccess() {
    let expectation = XCTestExpectation(description: "Should trigger onLogin closure")
    let apiUser = User(id: 1)
    let behaviour = SplashConcreteBehaviour(resolver: FakeLoginResolver(user: apiUser)) { user in
      XCTAssertEqual(apiUser.id, user.id)
      expectation.fulfill()
    }
    
    behaviour.login()
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
}
