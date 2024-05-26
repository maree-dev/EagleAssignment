//
//  EmployeeTableViewCell.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class EmployeeTableViewCell: UITableViewCell {
  @IBOutlet weak var viewContent: UIView!
  private let card: EmployeeCardView = .instance()!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    viewContent.fill(with: card)
  }
  
  func fill(with model: EmployeeCardDisplayable) {
    card.fill(with: model)
  }
}
