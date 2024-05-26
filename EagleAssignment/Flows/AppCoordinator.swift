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
  func alert(for message: APIError)
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
    controller.onError = {[weak self] in self?.alert(for: $0)}
    navigation.viewControllers = [controller]
  }
  
  func dashboard() {
    guard let controller: TabViewController = .instance() else {return}
    controller.onLogout = {[weak self] in self?.logout()}
    controller.onError = {[weak self] in self?.alert(for: $0)}
    navigation.viewControllers = [controller]
  }
  
  func alert(for error: APIError) {
    let alert: FlashMessageView = .instance()!
    alert.message = error.errorDescription
    alert.show(in: window)
  }
  
  func logout() {
    TokenStorage.removeToken()
    NetworkManager.shared.token = nil
    authenticate()
  }
}
