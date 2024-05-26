//
//  EmployeeCardView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

protocol EmployeeCardDisplayable {
  var employeeCardName: String {get}
  var employeeCardAddress: String {get}
  var employeeCardPhone: String {get}
}

struct BaseEmployeeCardDisplayable: EmployeeCardDisplayable {
  var employeeCardName: String
  var employeeCardAddress: String
  var employeeCardPhone: String
}

final class EmployeeCardView: UIView {
  // MARK: - Outlets
  @IBOutlet weak var labelName: UILabel!
  @IBOutlet weak var labelAddress: UILabel!
  @IBOutlet weak var labelPhone: UILabel!
  
  // MARK: - Public Methods
  func fill(with model: EmployeeCardDisplayable) {
    labelName.text = model.employeeCardName
    labelAddress.text = model.employeeCardAddress
    labelPhone.text = model.employeeCardPhone
  }
}
