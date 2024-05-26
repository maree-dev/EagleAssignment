//
//  TokenStorage.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import Foundation
import SwiftKeychainWrapper

class TokenStorage {
  
  class func store(_ token: AccessToken) {
    guard let token = token.token else {return}
    guard let bundleID = Bundle.main.bundleIdentifier else {return}
    KeychainWrapper.standard.set(token, forKey: "\(bundleID).\(Constants.token.rawValue)")
  }
  
  
  class func token() -> AccessToken? {
    guard let bundleID = Bundle.main.bundleIdentifier else {return nil}
    guard let token = KeychainWrapper.standard.string(forKey: "\(bundleID).\(Constants.token.rawValue)") else {return nil}
    return AccessToken(token: token)
  }
  
  class func removeToken() {
    guard let bundleID = Bundle.main.bundleIdentifier else {return}
    let key = KeychainWrapper.Key(rawValue: "\(bundleID).\(Constants.token.rawValue)")
    KeychainWrapper.standard.remove(forKey: key)
  }
  
  enum Constants: String {
    case token
  }
}
