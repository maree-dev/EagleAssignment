//
//  NetworkManager.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import Foundation

class NetworkManager {
  static let shared = NetworkManager()
  
  var token: AccessToken?
  var networkQueue = [Requestable]()
  
  private var headers: [String: String] {
    guard let accessToken = token?.token else {return [:]}
    return ["Authorization": "Basic \(accessToken)"]
  }
  
  // MARK: - Public methods
  /**
   Adds a new Requestable to the network queue. Time of execution is handled by the network manager depending on network usage and users session
   - parameter request: Object conforming to the Requestable protocol that needs to be scheduled for execution
   */
  class func add(request: Requestable) {
    shared.networkQueue.append(request)
    if shared.networkQueue.count == 1 {
      shared.processNext()
    }
  }
  
  // MARK: - Private methods
  private func processNext() {
    guard let nextRequest = networkQueue.first else {return}
    process(request: nextRequest)
  }
  
  private func process(request: Requestable, refresh: Bool = true) {
    request.send(headers: headers, refresh: refresh) { (response) in
      if self.networkQueue.count > 0 {
        self.networkQueue.remove(at: 0)
        self.processNext()
      }
    }
  }
}
