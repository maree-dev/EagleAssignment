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
    
    do {
      let model = try JSONDecoder().decode(Model.self, from: data)
      return APIResponse(data: model, error: nil)
    } catch {
      // Try to parse as error
      let error = try? JSONDecoder().decode(APIError.self, from: data)
      return APIResponse<Model>(data: nil, error: error ?? APIError.generic)
    }
  }
}
