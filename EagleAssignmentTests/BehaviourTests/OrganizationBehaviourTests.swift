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
  }
  
  func testInitial() {
    let resolver = FakeOrganizationCounterResolver()
    behaviour = OrganizationConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    
    XCTAssertTrue(state.isLoading)
    XCTAssertTrue(state.models.isEmpty)
    XCTAssertEqual(resolver.callCount, 1)
  }
  
  func testLoadError() {
    /// given
    let expectation = XCTestExpectation(description: "Should return error")
    let apiError = APIError.generic
    behaviour = OrganizationConcreteBehaviour(resolver: FakeOrganizationResolver(error: apiError), onError: { error in
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
    let items = [User(id: 1), User(id: 2), User(id: 3)]
    behaviour = OrganizationConcreteBehaviour(resolver: FakeOrganizationResolver(items: items))
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

final class FakeOrganizationResolver: OrganizationResolver {
  let items: [User]?
  let error: APIError?
  
  init(items: [User]? = nil, error: APIError? = nil) {
    self.items = items
    self.error = error
  }
  
  func resolve(completion: @escaping DoubleParameterClosure<[User]?, APIError?>) {
    completion(items, error)
  }
}

final class FakeOrganizationCounterResolver: OrganizationResolver {
  var callCount = 0
  
  func resolve(completion: @escaping DoubleParameterClosure<[User]?, APIError?>) {
    callCount += 1
    completion(nil, nil)
  }
}
