//
//  NetworkRequest.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}

enum DataResponse {
  case finished
  case unauthenticated
}

struct RefreshTokenError {
  static let value = "JWT expired at"
}

typealias NetworkCompletion<Model> = (Model?, APIError?) -> Void
typealias DataCompletion = (DataResponse) -> Void

protocol Requestable {
  func send(headers: [String: String], refresh: Bool, completion: DataCompletion?)
  func cancel()
}

class JSONNetworkRequest<Model: Decodable>: Requestable {
  
  var baseUrl: String
  var path: String?
  var method: HTTPMethod
  var parameters: [String: Any]?
  var completion: NetworkCompletion<Model>?
  
  init(baseUrl: String,
       path: String?,
       method: HTTPMethod,
       parameters: [String: Any]? = nil,
       completion: NetworkCompletion<Model>?) {
    self.baseUrl = baseUrl
    self.path = path
    self.method = method
    self.parameters = parameters
    self.completion = completion
  }
  
  func send(headers: [String: String], refresh: Bool, completion: DataCompletion?) {
    
    var adjustedHeaders = headers
    adjustedHeaders["Content-Type"] = "application/json"
    
    let urlMethods: [HTTPMethod] = [.get, .delete]
    var encoding: ParameterEncoding = JSONEncoding.default
    if urlMethods.contains(method) {
      encoding = URLEncoding.default
    }
    
    AF.request(
      baseUrl+(path ?? ""),
      method: Alamofire.HTTPMethod(rawValue: method.rawValue),
      parameters: parameters,
      encoding: encoding,
      headers: HTTPHeaders(adjustedHeaders))
    .responseData { response in
      if let errorCode = (response.error?.underlyingError as? NSError)?.code, errorCode == -1009 {
        completion?(.finished)
        self.completion?(nil, APIError.noInternet)
        return
      }
      let error = try? JSONDecoder().decode(APIError.self, from: response.data ?? Data())
      guard error?.message?.contains(RefreshTokenError.value) != true else {
        // Refresh
        completion?(.unauthenticated)
        if !refresh {
          self.completion?(nil, APIError.unauthenticated)
        }
        return
      }
      
      let parsed = JSONParser<Model>.parseAPIResponse(data: response.data)
      self.completion?(parsed?.data, parsed?.error)
      completion?(.finished)
    }
  }
  
  func cancel() {
    completion = nil
  }
}
