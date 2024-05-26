//
//  TabViewController.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import UIKit

final class TabViewController: UITabBarController {
  // MARK: - Flows
  var onLogout: VoidClosure?
  var onError: SingleParameterClosure<APIError>?
  
  // MARK: - Properties
  let usedDays: UsedDaysViewController = .instance()!
  let organization: OrganizationViewController = .instance()!
  let myInfo: MyInfoViewController = .instance()!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupControllers()
    bindActions()
  }
  
  private func setupControllers() {
    viewControllers = [organization, usedDays, myInfo]
    
    let firstTab = tabBar.items![0]
    firstTab.title = Strings.Tab.firstItem
    firstTab.image = .building
    firstTab.selectedImage = .buildingFill
    
    let secondTab = tabBar.items![1]
    secondTab.title = Strings.Tab.secondItem
    secondTab.image = .list
    secondTab.selectedImage = .listFill
    
    let thirdTab = tabBar.items![2]
    thirdTab.title = Strings.Tab.thirdItem
    thirdTab.image = .person
    thirdTab.selectedImage = .personFill
  }
  
  private func bindActions() {
    organization.onError = {[weak self] in self?.onError?($0)}
    usedDays.onError = {[weak self] in self?.onError?($0)}
    myInfo.onError = {[weak self] in self?.onError?($0)}
    myInfo.onLogout = {[weak self] in self?.onLogout?()}
  }
}
