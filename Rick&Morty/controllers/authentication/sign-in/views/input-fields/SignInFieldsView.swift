//
//  SignInFieldsView.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import UIKit

protocol SignInFieldsViewDelegate {
    func didChangeEmail(currentValue: String)
    func didChangePassword(currentValue: String)
}

@IBDesignable
class SignInFieldsView: BaseView {
    @IBOutlet weak var emailTextField: TitledTextField!
    @IBOutlet weak var passwordTextField: TitledTextField!
    
    var delegate: SignInFieldsViewDelegate?
    
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
    }
}

extension SignInFieldsView: TitledTextFieldDelegate {
    func didChangeValue(currentValue: String, sender: UIView) {
        switch sender {
        case emailTextField:
            delegate?.didChangeEmail(currentValue: currentValue)
        case passwordTextField:
            delegate?.didChangePassword(currentValue: currentValue)
        default:
            break
        }
    }
}
