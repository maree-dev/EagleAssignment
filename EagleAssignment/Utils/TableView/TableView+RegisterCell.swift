//
//  TableView+RegisterCell.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

extension UITableView {
  func register<T: UITableViewCell>(_ cell: T.Type) {
    let nib = UINib(nibName: T.identifier, bundle: Bundle(for: T.self))
    register(nib, forCellReuseIdentifier: T.identifier)
  }
}
