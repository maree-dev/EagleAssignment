//
//  AppCoordinator.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import UIKit

protocol AppCoordinator: Coordinator {
  func authenticate()
  func dashboard(_ user: User)
}

final class AppConcreteCoordinator {
  private let window: UIWindow
  private let navigation: UINavigationController
  
  init() {
    navigation = UINavigationController()
    window = UIWindow()
    window.rootViewController = navigation
    window.makeKeyAndVisible()
  }
}

extension AppConcreteCoordinator: AppCoordinator {
  func start() {
    guard let controller: SplashViewController = .instance() else {return}
    navigation.viewControllers = [controller]
  }
  
  func dismiss() {}
  
  func authenticate() {
    // Login
  }
  
  func dashboard(_ user: User) {
    // Dashboard
  }
}
