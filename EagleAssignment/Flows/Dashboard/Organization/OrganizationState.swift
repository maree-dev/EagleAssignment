//
//  OrganizationState.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

final class OrganizationState {
  var models: [EmployeeCardDisplayable]
  var isLoading: Bool
  
  init(models: [EmployeeCardDisplayable] = [], isLoading: Bool = false) {
    self.models = models
    self.isLoading = isLoading
  }
}
