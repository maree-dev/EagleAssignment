//
//  APIResponse.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

struct APIResponse<Model: Decodable>: Decodable {
  var data: Model?
  var error: APIError?
}

struct Items<Model: Decodable>: Decodable {
  var items: Model?
}
