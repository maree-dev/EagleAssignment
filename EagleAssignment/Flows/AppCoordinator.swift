//
//  AppCoordinator.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 24.05.2024.
//

import UIKit

protocol AppCoordinator: Coordinator {
  func authenticate()
  func dashboard()
  func logout()
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
    controller.onSuccess = {[weak self] in self?.dashboard()}
    controller.onFail = {[weak self] in self?.authenticate()}
    navigation.viewControllers = [controller]
  }
  
  func authenticate() {
    guard let controller: LoginViewController = .instance() else {return}
    controller.onLogin = {[weak self] in self?.dashboard()}
    navigation.viewControllers = [controller]
  }
  
  func dashboard() {
    guard let controller: TabViewController = .instance() else {return}
    controller.onLogout = {[weak self] in self?.logout()}
    navigation.viewControllers = [controller]
  }
  
  func logout() {
    TokenStorage.removeToken()
    NetworkManager.shared.token = nil
    authenticate()
  }
}
