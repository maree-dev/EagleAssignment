//
//  UsedDaysState.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

final class UsedDaysState {
  var models: [String]
  var isLoading: Bool
  
  init(models: [String] = [], isLoading: Bool = false) {
    self.models = models
    self.isLoading = isLoading
  }
}
