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
  
  private let resolver: OrganizationResolver
  private weak var state: OrganizationState!
  
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
          // TODO: - Handle data
          self?.state.models = ["placeholder"]
        }
        else {self?.onError?(error ?? .generic)}
      }
    }
  }
}
