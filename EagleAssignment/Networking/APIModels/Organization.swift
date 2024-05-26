//
//  Organization.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import Foundation

struct Organization: Decodable {
  var items: [User]?
  var total: Int?
}
