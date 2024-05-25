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
//    guard let controller: SplashViewController = .instance() else {return}
//    controller.onFinish = {[weak self] in self?.dashboard($0)}
//    controller.onError = {[weak self] in self?.authenticate()}
//    
//    navigation.viewControllers = [controller]
    
    dashboard(User())
  }
  
  func dismiss() {}
  
  func authenticate() {
    guard let controller: LoginViewController = .instance() else {return}
    navigation.viewControllers = [controller]
  }
  
  func dashboard(_ user: User) {
    guard let controller: TabViewController = .instance() else {return}
    navigation.viewControllers = [controller]
  }
}
