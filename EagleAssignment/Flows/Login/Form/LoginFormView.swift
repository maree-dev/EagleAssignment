//
//  LoginFormView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

final class LoginFormView: UIView {
  // MARK: - Outlets
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var stackView: UIStackView!
  
  // MARK: - Properties
  let emailField: InputFieldView = .instance(keyboardType: .emailAddress)!
  let passwordField: InputFieldView = .instance(keyboardType: .default, secured: true)!
  
  // MARK: - ViewLifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  // MARK: - Private Methods
  private func setupView() {
    imageView.image = .person
    labelTitle.text = Strings.Login.heading
    emailField.placeholder = Strings.Login.emailPlaceholder
    passwordField.placeholder = Strings.Login.passwordPlaceholder
    
    stackView.addArrangedSubview(emailField)
    stackView.addArrangedSubview(passwordField)
  }
}
