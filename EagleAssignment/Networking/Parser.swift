//
//  Parser.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

final class JSONParser<Model: Decodable> {
  class func parseAPIResponse(data: Data?) -> APIResponse<Model>? {
    guard let data = data else {
      return APIResponse(data: nil, error: APIError.generic)
    }
    
    // See if error is parsing
    if let error = try? JSONDecoder().decode(APIError.self, from: data), error.valid {
      return APIResponse(data: nil, error: error)
    }
    
    do {
      let model = try JSONDecoder().decode(Model.self, from: data)
      return APIResponse(data: model, error: nil)
    } catch {
      // Try to parse as error
      let error = try? JSONDecoder().decode(APIError.self, from: data)
      return APIResponse(data: nil, error: error ?? APIError.generic)
    }
  }
}
