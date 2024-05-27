//
//  InputFieldView.swift
//  EagleAssignment
//
//  Created by Marko Bozilovic on 26.05.2024.
//

import UIKit

struct InputFieldStyle {
  var borderColor: UIColor
  var backgroundColor: UIColor
  var textColor: UIColor
  var borderWidth: CGFloat
}

extension InputFieldStyle {
  static let rest = InputFieldStyle(borderColor: .gray, backgroundColor: .white, textColor: .black, borderWidth: 1)
  static let focused = InputFieldStyle(borderColor: .blue, backgroundColor: .white, textColor: .black, borderWidth: 1.5)
  static let error = InputFieldStyle(borderColor: .red, backgroundColor: .white, textColor: .black, borderWidth: 1)
  static let disabled = InputFieldStyle(borderColor: .systemGray6, backgroundColor: .systemGray6, textColor: .gray, borderWidth: 0)
}

final class InputFieldView: UIView {
  // MARK: - Actions
  var onEdit: SingleParameterClosure<String>?
  
  // MARK: - Outlets
  @IBOutlet weak var labelTitle: UILabel!
  @IBOutlet weak var labelError: UILabel!
  @IBOutlet weak var textField: UITextField!
  
  // MARK: - Properties
  var title: String? {
    didSet {labelTitle.text = title}
  }
  
  var text: String? {
    didSet {textField.text = text}
  }
  
  var placeholder: String? {
    didSet {textField.placeholder = placeholder}
  }
  
  var error: String? {
    didSet {handleError()}
  }
  
  var keyboardType: UIKeyboardType = .default {
    didSet {handleKeyboardType()}
  }
  
  var secured: Bool = false {
    didSet {textField.isSecureTextEntry = secured}
  }
  
  var disabled: Bool = false {
    didSet {style = disabled ? .disabled : .rest}
  }
  
  private var style: InputFieldStyle = .rest {
    didSet {render()}
  }
  
  // MARK: - View LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  // MARK: - Init
  class func instance(keyboardType: UIKeyboardType, title: String? = nil, disabled: Bool = false, secured: Bool = false) -> InputFieldView? {
    guard let view: InputFieldView = .instance() else {return nil}
    view.keyboardType = keyboardType
    view.disabled = disabled
    view.secured = secured
    view.title = title
    
    return view
  }
  
  // MARK: - Private Methods
  private func setupView() {
    labelTitle.text = nil
    labelError.text = nil
    textField.layer.cornerRadius = Constants.cornerRadius
  }
  
  private func render() {
    textField.backgroundColor = style.backgroundColor
    textField.textColor = style.textColor
    textField.layer.borderColor = style.borderColor.cgColor
    textField.layer.borderWidth = style.borderWidth
    textField.layer.cornerRadius = Constants.cornerRadius
  }
  
  private func handleError() {
    labelError.text = error
    style = error == nil ? (disabled ? .disabled : .rest) : .error
  }
  
  private func handleKeyboardType() {
    if keyboardType == .phonePad {
      addDoneButton()
    } else {
      textField.inputAccessoryView = nil
    }
    textField.keyboardType = keyboardType
  }
  
  private func addDoneButton() {
    let toolbar = UIToolbar()
    toolbar.bounds.size = CGSize(width: bounds.width, height: Constants.toolbarHeight)
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    toolbar.setItems([flexSpace, doneButton], animated: false)
    
    textField.inputAccessoryView = toolbar
  }
  
  @objc private func doneButtonTapped() {
    textField.resignFirstResponder()
  }
}

extension InputFieldView: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    onEdit?(textField.text ?? "")
  }
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    !disabled
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    error = nil
    style = .focused
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    style = .rest
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

extension InputFieldView {
  private struct Constants {
    static let cornerRadius: CGFloat = 4
    static let toolbarHeight: CGFloat = 46
    static let animationDuration: CGFloat = 0.3
  }
}
