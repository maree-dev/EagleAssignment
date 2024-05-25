//
//  OrganizationBehaviourTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import XCTest

final class OrganizationBehaviourTests: XCTestCase {
  var state: OrganizationState!
  var behaviour: OrganizationConcreteBehaviour!
  
  override func setUp() {
    state = OrganizationState()
    behaviour = OrganizationConcreteBehaviour(resolver: FakeOrganizationResolver())
    behaviour.setup(state)
  }
  
  func testInitial() {
    let resolver = FakeOrganizationCounterResolver()
    behaviour = OrganizationConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    
    XCTAssertEqual(state.models.count, 0)
    XCTAssertEqual(resolver.callCount, 1)
    XCTAssertTrue(state.isLoading)
  }
  
  func testLoadError() {
    let expectation = XCTestExpectation(description: "Should return error")
    let apiError = APIError.generic
    behaviour = OrganizationConcreteBehaviour(resolver: FakeOrganizationResolver(error: apiError), onError: { error in
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
    behaviour = OrganizationConcreteBehaviour(resolver: FakeOrganizationResolver(items: items))
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

final class FakeOrganizationResolver: OrganizationResolver {
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

final class FakeOrganizationCounterResolver: OrganizationResolver {
  var callCount = 0
  
  func resolver(completion: ([String]?, APIError?) -> Void) {
    callCount += 1
    completion(nil, nil)
  }
}
