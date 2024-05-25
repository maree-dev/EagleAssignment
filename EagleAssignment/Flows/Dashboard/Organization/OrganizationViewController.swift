//
//  OrganizationViewController.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import UIKit

final class OrganizationViewController: UIViewController {
  // MARK: - Flows
  var onError: SingleParameterClosure<APIError>?
  
  // MARK: - Properties
  private let state = OrganizationState()
  private let behaviour = OrganizationConcreteBehaviour(resolver: OrganizationConcreteResolver())
  
  // MARK: - ViewLifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    behaviour.setup(state)
    bindActions()
  }
  
  // MARK: - Private Methods
  private func bindActions() {
    behaviour.onError = {[weak self] in self?.onError?($0)}
  }
}
