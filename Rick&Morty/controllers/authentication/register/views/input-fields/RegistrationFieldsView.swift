//
//  InputFieldsView.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 16.02.2023.
//

import UIKit

protocol RegistrationFieldsViewDelegate {
    func didChangeEmail(currentValue: String)
    func didChangePassword(currentValue: String)
    func didChangePhoneNumber(currentValue: String)
}

@IBDesignable
class RegistrationFieldsView: BaseView {
    @IBOutlet weak var emailTextField: TitledTextField!
    @IBOutlet weak var passwordTextField: TitledTextField!
    @IBOutlet weak var phoneNumberTextField: TitledTextField!
    
    var delegate: RegistrationFieldsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
}

extension RegistrationFieldsView: TitledTextFieldDelegate {
    func didChangeValue(currentValue: String, sender: UIView) {
        switch sender {
        case emailTextField:
            delegate?.didChangeEmail(currentValue: currentValue)
        case passwordTextField:
            delegate?.didChangePassword(currentValue: currentValue)
        case phoneNumberTextField:
            delegate?.didChangePhoneNumber(currentValue: currentValue)
        default:
            break
        }
    }
}
