//
//  MyInfoAdapter.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import Foundation

final class MyInfoMapper {
  private weak var state: MyInfoState?
  
  init(state: MyInfoState?) {
    self.state = state
  }
  
  func updateState(with user: User) {
    state?.dateOfBirth = DateFormatterFactory.string(from: user.birthDate, format: .short)
    state?.hireDate = DateFormatterFactory.string(from: user.employmentDate, format: .short)
    state?.firstName = user.firstName
    state?.lastName = user.lastName
    state?.email = user.email
    state?.address = user.address
    state?.degree = user.degree
    state?.phone = user.phone
  }
}
