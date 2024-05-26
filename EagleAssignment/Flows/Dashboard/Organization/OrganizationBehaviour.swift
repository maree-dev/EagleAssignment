//
//  OrganizationBehaviour.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

protocol OrganizationBehaviour {
  func setup(_ state: OrganizationState)
  func load()
}

final class OrganizationConcreteBehaviour {
  var onError: SingleParameterClosure<APIError>?
  var onChange: VoidClosure?
  
  private let resolver: OrganizationResolver
  private weak var state: OrganizationState!
  private var employees: [User] = []
  
  init(resolver: OrganizationResolver,
       onError: SingleParameterClosure<APIError>? = nil) {
    
    self.resolver = resolver
    self.onError = onError
  }
}

extension OrganizationConcreteBehaviour: OrganizationBehaviour {
  func setup(_ state: OrganizationState) {
    self.state = state
    self.load()
  }
  
  func load() {
    state.isLoading = true
    
    resolver.resolve {[weak self] (users, error) in
      DispatchQueue.main.async {
        self?.state.isLoading = false
        
        if let users = users {
          self?.employees = users
          self?.state.models = OrganizationAdapter(users: users).convert()
        }
        else {self?.onError?(error ?? .generic)}
        
        self?.onChange?()
      }
    }
  }
}
