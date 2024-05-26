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
  
  // MARK: - Outlets
  @IBOutlet weak var viewContent: UIView!
  private let list: OrganizationListView = .instance()!
  private let spinner: ActivityView = .instance()!
  
  // MARK: - Properties
  private let state = OrganizationState()
  private let behaviour = OrganizationConcreteBehaviour(resolver: OrganizationConcreteResolver())
  
  // MARK: - ViewLifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    bindActions()
    behaviour.setup(state)
  }
  
  // MARK: - Private Methods
  private func setupView() {
    spinner.container = view
    viewContent.fill(with: list)
  }
  
  private func bindActions() {
    behaviour.onChange = {[weak self] in self?.render()}
    behaviour.onError = {[weak self] in self?.onError?($0)}
  }
  
  private func render() {
    list.fill(with: state.models)
    spinner.isActive = state.isLoading
  }
}
