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
  }
  
  func testInitial() {
    let resolver = FakeUsedDaysCounterResolver()
    behaviour = UsedDaysConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    
    XCTAssertTrue(state.isLoading)
    XCTAssertTrue(state.models.isEmpty)
    XCTAssertEqual(resolver.callCount, 1)
  }
  
  func testLoadError() {
    /// given
    let expectation = XCTestExpectation(description: "Should return error")
    let apiError = APIError.generic
    behaviour = UsedDaysConcreteBehaviour(resolver: FakeUsedDaysResolver(error: apiError), onError: { error in
      XCTAssertEqual(apiError.errorDescription, error.errorDescription)
      expectation.fulfill()
    })
    behaviour.setup(state)
    
    /// when
    behaviour.load()
    
    /// then
    XCTAssertTrue(state.isLoading)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
  
  func testLoadSuccess() {
    /// given
    let expectation = XCTestExpectation(description: "Should return items")
    let items = [Days()]
    behaviour = UsedDaysConcreteBehaviour(resolver: FakeUsedDaysResolver(items: items))
    behaviour.setup(state)
    
    /// when
    behaviour.load()
    
    /// then
    XCTAssertTrue(state.isLoading)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
      XCTAssertFalse(self.state.models.isEmpty)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
}

final class FakeUsedDaysResolver: UsedDaysResolver {
  let items: [Days]?
  let error: APIError?
  
  init(items: [Days]? = nil, error: APIError? = nil) {
    self.items = items
    self.error = error
  }
  
  func resolve(completion: @escaping DoubleParameterClosure<[Days]?, APIError?>) {
    completion(items, error)
  }
}

final class FakeUsedDaysCounterResolver: UsedDaysResolver {
  var callCount = 0
  
  func resolve(completion: @escaping DoubleParameterClosure<[Days]?, APIError?>) {
    callCount += 1
    completion(nil, nil)
  }
}
