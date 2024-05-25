//
//  UsedDaysBehaviourTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import XCTest

final class UsedDaysBehaviourTests: XCTestCase {
  var state: UsedDaysState!
  var behaviour: UsedDaysConcreteBehaviour!
  
  override func setUp() {
    state = UsedDaysState()
    behaviour = UsedDaysConcreteBehaviour(resolver: FakeUsedDaysResolver())
    behaviour.setup(state)
  }
  
  func testInitial() {
    let resolver = FakeUsedDaysCounterResolver()
    behaviour = UsedDaysConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    
    XCTAssertEqual(state.models.count, 0)
    XCTAssertEqual(resolver.callCount, 1)
    XCTAssertTrue(state.isLoading)
  }
  
  func testLoadError() {
    let expectation = XCTestExpectation(description: "Should return error")
    let apiError = APIError.generic
    behaviour = UsedDaysConcreteBehaviour(resolver: FakeUsedDaysResolver(error: apiError), onError: { error in
      XCTAssertEqual(apiError.errorDescription, error.errorDescription)
      expectation.fulfill()
    })
    behaviour.setup(state)
    
    behaviour.load()
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
  
  func testLoadSuccess() {
    let expectation = XCTestExpectation(description: "Should return items")
    let items = ["item1", "item2", "item3"]
    behaviour = UsedDaysConcreteBehaviour(resolver: FakeUsedDaysResolver(items: items))
    behaviour.setup(state)
    
    behaviour.load()
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
      XCTAssertEqual(self.state.models.count, items.count)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
}

final class FakeUsedDaysResolver: UsedDaysResolver {
  let items: [String]?
  let error: APIError?
  
  init(items: [String]? = nil, error: APIError? = nil) {
    self.items = items
    self.error = error
  }
  
  func resolver(completion: ([String]?, APIError?) -> Void) {
    completion(items, error)
  }
}

final class FakeUsedDaysCounterResolver: UsedDaysResolver {
  var callCount = 0
  
  func resolver(completion: ([String]?, APIError?) -> Void) {
    callCount += 1
    completion(nil, nil)
  }
}
