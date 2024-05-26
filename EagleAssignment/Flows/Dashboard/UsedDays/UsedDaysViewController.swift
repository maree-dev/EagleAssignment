//
//  UsedDaysViewController.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import UIKit

final class UsedDaysViewController: UIViewController {
  // MARK: - Flows
  var onError: SingleParameterClosure<APIError>?
  
  // MARK: - Outlets
  @IBOutlet weak var viewContent: UIView!
  private let list: UsedDaysListView = .instance()!

  // MARK: - Properties
  private let state = UsedDaysState()
  private let behaviour = UsedDaysConcreteBehaviour(resolver: UsedDaysConcreteResolver())
  
  // MARK: - ViewLifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    behaviour.setup(state)
    bindActions()
    setupView()
  }
  
  // MARK: - Private Methods
  private func setupView() {
    viewContent.fill(with: list)
  }
  
  private func bindActions() {
    behaviour.onError = {[weak self] in self?.onError?($0)}
    behaviour.onChange = {[weak self] in self?.render()}
  }
  
  private func render() {
    list.fill(with: state.models)
  }
}
