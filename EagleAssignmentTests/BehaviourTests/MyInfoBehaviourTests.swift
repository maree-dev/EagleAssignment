//
//  MyInfoBehaviourTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import XCTest

final class MyInfoBehaviourTests: XCTestCase {
  var state: MyInfoState!
  var behaviour: MyInfoBehaviour!
  
  override func setUp() {
    state = MyInfoState()
    behaviour = MyInfoConcreteBehaviour(resolver: FakeMyInfoCounterResolver())
    behaviour.setup(state)
  }
  
  func testInitial() {
    let resolver = FakeMyInfoCounterResolver()
    behaviour = MyInfoConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    
    XCTAssertNil(state.firstName)
    XCTAssertNil(state.lastName)
    XCTAssertNil(state.dateOfBirth)
    XCTAssertNil(state.hireDate)
    XCTAssertNil(state.email)
    XCTAssertNil(state.emailError)
    XCTAssertNil(state.address)
    XCTAssertNil(state.degree)
    XCTAssertNil(state.phone)
    XCTAssertTrue(state.isLoading)
    XCTAssertEqual(resolver.profileCounter, 1)
    XCTAssertEqual(resolver.updateCounter, 0)
  }
  
  func testEmailInput() {
    /// when
    behaviour.set(email: "mile@jna.rs")
    
    /// then
    XCTAssertEqual(state.email, "mile@jna.rs")
    XCTAssertNil(state.firstName)
    XCTAssertNil(state.lastName)
    XCTAssertNil(state.dateOfBirth)
    XCTAssertNil(state.hireDate)
    XCTAssertNil(state.emailError)
    XCTAssertNil(state.address)
    XCTAssertNil(state.degree)
    XCTAssertNil(state.phone)
  }
  
  func testAddressInput() {
    /// when
    behaviour.set(address: "test adresa")
    
    /// then
    XCTAssertEqual(state.address, "test adresa")
    XCTAssertNil(state.firstName)
    XCTAssertNil(state.lastName)
    XCTAssertNil(state.dateOfBirth)
    XCTAssertNil(state.hireDate)
    XCTAssertNil(state.email)
    XCTAssertNil(state.emailError)
    XCTAssertNil(state.degree)
    XCTAssertNil(state.phone)
  }
  
  func testDeggreInput() {
    /// when
    behaviour.set(degree: "forklift certified")
    
    /// then
    XCTAssertEqual(state.degree, "forklift certified")
    XCTAssertNil(state.firstName)
    XCTAssertNil(state.lastName)
    XCTAssertNil(state.dateOfBirth)
    XCTAssertNil(state.hireDate)
    XCTAssertNil(state.email)
    XCTAssertNil(state.emailError)
    XCTAssertNil(state.address)
    XCTAssertNil(state.phone)
  }
  
  func testPhoneInput() {
    /// when
    behaviour.set(phone: "00000000")
    
    /// then
    XCTAssertEqual(state.phone, "00000000")
    XCTAssertNil(state.firstName)
    XCTAssertNil(state.lastName)
    XCTAssertNil(state.dateOfBirth)
    XCTAssertNil(state.hireDate)
    XCTAssertNil(state.email)
    XCTAssertNil(state.emailError)
    XCTAssertNil(state.address)
    XCTAssertNil(state.degree)
  }
  
  func testLoadFail() {
    /// given
    let expectation = XCTestExpectation(description: "Should return error")
    let apiError = APIError.generic
    behaviour = MyInfoConcreteBehaviour(resolver: FakeMyInfoResolver(error: apiError), onError: { error in
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
    let expectation = XCTestExpectation(description: "Should load and map user")
    behaviour = MyInfoConcreteBehaviour(resolver: FakeMyInfoResolver(user: FakeMyInfoResolver.fakeUser))
    behaviour.setup(state)
    
    /// when
    behaviour.load()
    
    /// then
    XCTAssertTrue(state.isLoading)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
      XCTAssertNotNil(self.state.firstName)
      XCTAssertNotNil(self.state.lastName)
      XCTAssertNotNil(self.state.dateOfBirth)
      XCTAssertNotNil(self.state.hireDate)
      XCTAssertNotNil(self.state.email)
      XCTAssertNotNil(self.state.address)
      XCTAssertNotNil(self.state.degree)
      XCTAssertNotNil(self.state.phone)
      expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
  
  func testLogout() {
    /// given
    let expectation = XCTestExpectation(description: "Should trigger logout")
    behaviour = MyInfoConcreteBehaviour(resolver: FakeMyInfoCounterResolver(), onLogout: {
      expectation.fulfill()
    })
    behaviour.setup(state)
    
    /// when
    behaviour.logout()
    
    /// then
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
}

class FakeMyInfoResolver: MyInfoResolver {
  let user: User?
  let error: APIError?
  
  init(user: User? = nil, error: APIError? = nil) {
    self.user = user
    self.error = error
  }
  
  func profile(completion: @escaping DoubleParameterClosure<User?, APIError?>) {
    completion(user, error)
  }
  
  func update(params: UserParameters?, completion: @escaping DoubleParameterClosure<EmptyResponse?, APIError?>) {
    completion(nil, error)
  }
}

extension FakeMyInfoResolver {
  static let fakeUser = User(
    email: "email",
    firstName: "first name",
    lastName: "last name",
    address: "address",
    phone: "phone",
    degree: "degree",
    dateOfBirth: "dob",
    hireDate: "hire date")
}

class FakeMyInfoCounterResolver: MyInfoResolver {
  var profileCounter = 0
  var updateCounter = 0
  
  func profile(completion: @escaping DoubleParameterClosure<User?, APIError?>) {
    profileCounter += 1
    completion(nil, nil)
  }
  
  func update(params: UserParameters?, completion: @escaping DoubleParameterClosure<EmptyResponse?, APIError?>) {
    updateCounter += 1
    completion(nil, nil)
  }
}
