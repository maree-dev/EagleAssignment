//
//  UsedDaysBehaviour.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

protocol UsedDaysBehaviour {
  func setup(_ state: UsedDaysState)
  func load()
}

final class UsedDaysConcreteBehaviour {
  var onError: SingleParameterClosure<APIError>?
  
  private let resolver: UsedDaysResolver
  private weak var state: UsedDaysState!
  
  init(resolver: UsedDaysResolver,
       onError: SingleParameterClosure<APIError>? = nil) {
    
    self.resolver = resolver
    self.onError = onError
  }
}

extension UsedDaysConcreteBehaviour: UsedDaysBehaviour {
  func setup(_ state: UsedDaysState) {
    self.state = state
    self.load()
  }
  
  func load() {
    state.isLoading = true
    
    resolver.resolve {[weak self] (days, error) in
      DispatchQueue.main.async {
        self?.state.isLoading = false
        
        if let days = days {
          // TODO: - Handle data
          self?.state.models = ["placeholder"]
        }
        
        else {self?.onError?(error ?? .generic)}
      }
    }
  }
}
