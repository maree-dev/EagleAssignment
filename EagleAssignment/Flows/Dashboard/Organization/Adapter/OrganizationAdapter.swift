//
//  OrganizationAdapter.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import Foundation

final class OrganizationAdapter {
  private let users: [User]
  
  init(users: [User]) {
    self.users = users
  }
  
  func convert() -> [EmployeeCardDisplayable] {
    var models = [EmployeeCardDisplayable]()
    
    users.forEach { user in
      let name = (user.firstName ?? "") + " " + (user.lastName ?? "")
      let address = user.address?.isEmpty == false ? user.address! : "-"
      let phone = user.phone?.isEmpty == false ? user.phone! : "-"
      
      models.append(BaseEmployeeCardDisplayable(employeeCardName: name.capitalized, employeeCardAddress: address, employeeCardPhone: phone))
    }
    
    return models
  }
}
