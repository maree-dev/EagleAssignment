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
  
  init(resolver: OrganizationResolver,
       onError: SingleParameterClosure<APIError>? = nil) {
    
    self.resolver = resolver
    self.onError = onError
  }
}

extension OrganizationConcreteBehaviour: OrganizationBehaviour {
  func setup(_ state: OrganizationState) {
    
  }
  
  func load() {
    
  }
}
