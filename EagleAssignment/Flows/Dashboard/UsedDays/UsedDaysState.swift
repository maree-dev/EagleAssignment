//
//  UsedDaysState.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

final class UsedDaysState {
  var models: [InfoCardDisplayable]
  var isLoading: Bool
  
  init(models: [InfoCardDisplayable] = [], isLoading: Bool = false) {
    self.models = models
    self.isLoading = isLoading
  }
}
