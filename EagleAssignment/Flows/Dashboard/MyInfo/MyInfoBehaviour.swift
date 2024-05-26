//
//  MyInfoBehaviour.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import Foundation

protocol MyInfoBehaviour {
  func setup(_ state: MyInfoState)
  func set(email: String)
  func set(address: String)
  func set(degree: String)
  func set(phone: String)
  func load()
  func save()
  func logout()
}

final class MyInfoConcreteBehaviour {
  var onError: SingleParameterClosure<APIError>?
  var onLogout: VoidClosure?
  var onChange: VoidClosure?
  
  private let resolver: MyInfoResolver
  private weak var state: MyInfoState!
  
  init(resolver: MyInfoResolver,
       onError: SingleParameterClosure<APIError>? = nil,
       onLogout: VoidClosure? = nil) {
    
    self.resolver = resolver
    self.onError = onError
    self.onLogout = onLogout
  }
  
  private func validateInputs() -> Bool {
    let email = state.email ?? ""
    let isEmailValid = ValidatorFactory.validator(for: .email(email)).validate()
    state.emailError = isEmailValid ? nil : Strings.Login.emailError
    
    return isEmailValid
  }
}

extension MyInfoConcreteBehaviour: MyInfoBehaviour {
  func setup(_ state: MyInfoState) {
    self.state = state
    self.load()
  }
  
  func set(email: String) {
    state.email = email
  }
  
  func set(address: String) {
    state.address = address
  }
  
  func set(degree: String) {
    state.degree = degree
  }
  
  func set(phone: String) {
    state.phone = phone
  }
  
  func load() {
    state.isLoading = true
    onChange?()
    
    resolver.profile {[weak self] (user, error) in
      DispatchQueue.main.async {
        if let user = user {
          let mapper = MyInfoMapper(state: self?.state)
          mapper.updateState(with: user)
        } else {
          self?.onError?(error ?? .generic)
        }
        
        self?.state.isLoading = false
        self?.onChange?()
      }
    }
  }
  
  func save() {
    guard validateInputs(), !state.isLoading else {return}
    state.isLoading = true
    
    // TODO: - Add parameters
    resolver.update(params: nil) {[weak self] (_ , error) in
      DispatchQueue.main.async {
        if let error = error {self?.onError?(error)}
        self?.state.isLoading = false
        self?.onChange?()
      }
    }
  }
  
  func logout() {
    onLogout?()
  }
}
