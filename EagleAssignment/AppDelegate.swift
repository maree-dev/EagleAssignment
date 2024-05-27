//
//  AppDelegate.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import UIKit
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  private var coordinator: Coordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    coordinator = AppConcreteCoordinator()
    coordinator?.start()
    
    #if DEBUG
    NFX.sharedInstance().start()
    #endif
    
    return true
  }
}
