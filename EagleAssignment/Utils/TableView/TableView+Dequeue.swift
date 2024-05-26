//
//  TableView+Dequeue.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

extension UITableView {
  func dequeueReusableCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
    dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
  }
}

