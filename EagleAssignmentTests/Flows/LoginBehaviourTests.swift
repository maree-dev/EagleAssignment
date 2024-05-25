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
    XCTAssertEqual(state.email, "")
    XCTAssertEqual(state.password, "")
    XCTAssertFalse(state.isLoading)
  }
  
  func testEmail() {
    behaviour.set(email: "mileJNA@gmail.com")
    XCTAssertEqual(state.email, "mileJNA@gmail.com")
  }
  
  func testPassword() {
    behaviour.set(password: "mileeeee")
    XCTAssertEqual(state.password, "mileeeee")
  }
  
  func testEmptyLogin() {
    let resolver = FakeCounterLoginResolver()
    behaviour = LoginConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    
    behaviour.login()

    XCTAssertFalse(state.isLoading)
    XCTAssertEqual(resolver.callCount, 0)
  }
  
  func testLogin() {
    let resolver = FakeCounterLoginResolver()
    behaviour = LoginConcreteBehaviour(resolver: resolver)
    behaviour.setup(state)
    behaviour.set(email: "mileJNA@gmail.com")
    behaviour.set(password: "mileeeee")
    
    behaviour.login()
    
    XCTAssertEqual(resolver.callCount, 1)
  }
  
  func testLoginError() {
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
    
    behaviour.login()
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
  
  func testLoginSuccess() {
    let expectation = XCTestExpectation(description: "Should return user")
    let apiUser = User(id: 1)
    let resolver = FakeLoginResolver(user: apiUser)
    behaviour = LoginConcreteBehaviour(resolver: resolver, onLogin: { user in
      XCTAssertEqual(apiUser.id, user.id)
      expectation.fulfill()
    })
    behaviour.setup(state)
    behaviour.set(email: "mileJNA@gmail.com")
    behaviour.set(password: "mileeeee")
    
    behaviour.login()
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+TestConstants.AsyncAfter) {
      XCTAssertFalse(self.state.isLoading)
    }
    
    wait(for: [expectation], timeout: TestConstants.AsyncWait)
  }
}

final class FakeLoginResolver: LoginResolver {
  let user: User?
  let error: APIError?
  
  init(user: User? = nil, error: APIError? = nil) {
    self.user = user
    self.error = error
  }
  
  func resolve(parameters: AuthParameters?, completion: @escaping DoubleParameterClosure<User?, APIError?>) {
    completion(user, error)
  }
}

final class FakeCounterLoginResolver: LoginResolver {
  var callCount = 0
  
  func resolve(parameters: AuthParameters?, completion: @escaping DoubleParameterClosure<User?, APIError?>) {
    callCount += 1
    completion(nil, nil)
  }
}
