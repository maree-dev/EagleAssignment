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
  var onChange: VoidClosure?
  
  private let resolver: UsedDaysResolver
  private weak var state: UsedDaysState!
  private var days: [Days] = []
  
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
    onChange?()
    
    resolver.resolve {[weak self] (days, error) in
      DispatchQueue.main.async {
        if let days = days {
          self?.days = days
          self?.state.models = UsedDaysAdapter(days: days).convert()
        } else {
          self?.onError?(error ?? .generic)
        }
        
        self?.state.isLoading = false
        self?.onChange?()
      }
    }
  }
}
