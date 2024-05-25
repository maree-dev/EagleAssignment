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
  
  init(resolver: UsedDaysResolver,
       onError: SingleParameterClosure<APIError>? = nil) {
    
    self.resolver = resolver
    self.onError = onError
  }
}

extension UsedDaysConcreteBehaviour: UsedDaysBehaviour {
  func setup(_ state: UsedDaysState) {
    
  }
  
  func load() {
    
  }
}
