//
//  MyInfoViewController.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 25.05.2024.
//

import UIKit

final class MyInfoViewController: UIViewController {
  // MARK: - Flows
  var onError: SingleParameterClosure<APIError>?
  var onLogout: VoidClosure?
  
  // MARK: - Outlets
  @IBOutlet weak var viewContent: UIView!
  private let form: MyInfoFormView = .instance()!
  private let spinner: ActivityView = .instance()!
  
  // MARK: - Properties
  private let state = MyInfoState()
  private let behaviour = MyInfoConcreteBehaviour(resolver: MyInfoConcreteResolver())
  private let keyboardHandler = KeyboardDetector()
  
  // MARK: - ViewLifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    bindActions()
    behaviour.setup(state)
  }
  
  // MARK: - Private Methods
  private func setupView() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    spinner.container = view
    viewContent.fill(with: form)
  }
  
  private func bindActions() {
    behaviour.onError = {[weak self] in self?.onError?($0)}
    behaviour.onLogout = {[weak self] in self?.onLogout?()}
    behaviour.onChange = {[weak self] in self?.render()}
    
    form.emailField.onEdit = {[weak self] in self?.behaviour.set(email: $0)}
    form.addressField.onEdit = {[weak self] in self?.behaviour.set(address: $0)}
    form.collegeField.onEdit = {[weak self] in self?.behaviour.set(degree: $0)}
    form.contactField.onEdit = {[weak self] in self?.behaviour.set(phone: $0)}
    form.onLogout = {[weak self] in self?.behaviour.logout()}
    
    keyboardHandler.onKeyboardWillAppear = {[weak self] in self?.form.adjust(for: $0)}
    keyboardHandler.onKeyboardWillDisappear = {[weak self] in self?.form.adjust(for: $0)}
  }
  
  private func render() {
    form.fill(with: state)
    spinner.isActive = state.isLoading
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
}
