//
//  MyInfoFormView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class MyInfoFormView: UIView {
  // MARK: - Actions
  var onLogout: VoidClosure?
  
  // MARK: - Outlets
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var stackView: UIStackView!
  let firstNameField: InputFieldView = .instance(keyboardType: .default, title: Strings.MyInfo.firstName, disabled: true)!
  let lastNameField: InputFieldView = .instance(keyboardType: .default, title: Strings.MyInfo.lastName, disabled: true)!
  let dateOfBirthField: InputFieldView = .instance(keyboardType: .default, title: Strings.MyInfo.dateOfBirth, disabled: true)!
  let hireDateField: InputFieldView = .instance(keyboardType: .default, title: Strings.MyInfo.hireDate, disabled: true)!
  let emailField: InputFieldView = .instance(keyboardType: .emailAddress, title: Strings.MyInfo.email)!
  let addressField: InputFieldView = .instance(keyboardType: .default, title: Strings.MyInfo.address)!
  let collegeField: InputFieldView = .instance(keyboardType: .default, title: Strings.MyInfo.college)!
  let contactField: InputFieldView = .instance(keyboardType: .phonePad, title: Strings.MyInfo.contactInfo)!
  
  let logoutButton: UIButton = UIButton(type: .system)
  
  // MARK: - View LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  // MARK: - Private Methods
  private func setupView() {
    logoutButton.setTitle(Strings.MyInfo.logout, for: .normal)
    logoutButton.setTitleColor(.red, for: .normal)
    logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
    
    [firstNameField, lastNameField, dateOfBirthField, hireDateField, emailField, addressField, collegeField, contactField]
      .forEach {stackView.addArrangedSubview($0)}
    
    stackView.addArrangedSubview(logoutButton)
  }
  
  @objc private func handleLogout() {onLogout?()}
  
  // MARK: - Public Methods
  func fill(with model: MyInfoState) {
    firstNameField.text = model.firstName
    lastNameField.text = model.lastName
    dateOfBirthField.text = model.dateOfBirth
    hireDateField.text = model.hireDate
    addressField.text = model.address
    collegeField.text = model.degree
    contactField.text = model.phone
    emailField.text = model.email
    emailField.error = model.emailError
  }
  
  func adjust(for value: CGFloat) {
    scrollView.contentInset.bottom = value
  }
}
