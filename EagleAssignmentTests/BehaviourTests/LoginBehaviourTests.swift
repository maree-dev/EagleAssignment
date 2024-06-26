//
//  LoginBehaviourTests.swift
//  EagleAssignmentTests
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import XCTest

final class LoginBehaviourTests: XCTestCase {
  var state: LoginState!
  var behaviour: LoginConcreteBehaviour!
  
  override func setUp() {
    super.setUp()
    state = LoginState()
    behaviour = LoginConcreteBehaviour(resolver: FakeCounterLoginResolver())
    behaviour.setup(state)
  }
  
  func testInitial() {
    XCTAssertTrue(state.email.isEmpty)
    XCTAssertTrue(state.password.isEmpty)
    XCTAssertFalse(state.isLoading)
  }
  
  func testEmail() {
    /// when
    behaviour.set(email: "mileJNA@gmail.com")
    
    /// then
    XCTAssertEqual(state.email, "mileJNA@gmail.com")
    XCTAssertTrue(state.password.isEmpty)
  }
  
  func testPassword() {
    /// when
    behaviour.set(password: "mileeeee")
    
    /// then
    XCTAssertEqual(state.password, "mileeeee")
    XCTAssertTrue(state.email.isEmpty)
  }
  
  func testEmptyLogin() {
    /// given
    let resolver = FakeCounterLoginResolver()
    behaviour = LoginConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    
    /// when
    behaviour.login()

    /// then
    XCTAssertFalse(state.isLoading)
    XCTAssertEqual(resolver.callCount, 0)
  }
  
  func testLogin() {
    /// given
    let resolver = FakeCounterLoginResolver()
    behaviour = LoginConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    behaviour.set(email: "mileJNA@gmail.com")
    behaviour.set(password: "mileeeee")
    
    /// when
    behaviour.login()
    
    /// then
    XCTAssertTrue(state.isLoading)
    XCTAssertEqual(resolver.callCount, 1)
  }
  
  func testLoginError() {
    /// given
    let expectation = XCTestExpectation(description: "Should return error")
    let apiError = APIError.generic
    let resolver = FakeLoginResolver(error: apiError)
    behaviour = LoginConcreteBehaviour(resolver: resolver, onError: { error in
      XCTAssertEqual(apiError.errorDescription, error.errorDescription)
      expectation.fulfill()
    })
    behaviour.setup(state)
    behaviour.set(email: "mileJNA@gmail.com")
    behaviour.set(password: "mileeeee")
    
    /// when
    behaviour.login()
    
    /// then
    XCTAssertTrue(state.isLoading)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
  
  func testLoginSuccess() {
    /// given
    let expectation = XCTestExpectation(description: "Should retrieve token")
    let resolver = FakeLoginResolver(token: AccessToken(token: "token"))
    behaviour = LoginConcreteBehaviour(resolver: resolver, onLogin: {
      expectation.fulfill()
    })
    behaviour.setup(state)
    behaviour.set(email: "mileJNA@gmail.com")
    behaviour.set(password: "mileeeee")
    
    /// when
    behaviour.login()
    
    /// then
    XCTAssertTrue(state.isLoading)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
}

final class FakeLoginResolver: LoginResolver {
  let token: AccessToken?
  let error: APIError?
  
  init(token: AccessToken? = nil, error: APIError? = nil) {
    self.token = token
    self.error = error
  }
  
  func resolve(parameters: AuthParameters?, completion: @escaping DoubleParameterClosure<AccessToken?, APIError?>) {
    completion(token, error)
  }
}

final class FakeCounterLoginResolver: LoginResolver {
  var callCount = 0
  
  func resolve(parameters: AuthParameters?, completion: @escaping DoubleParameterClosure<AccessToken?, APIError?>) {
    callCount += 1
    completion(nil, nil)
  }
}
