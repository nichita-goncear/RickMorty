//
//  RegisterViewModel.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func showEmptyFieldsAlert()
    func showEmailWrongFormatAlert()
    func showPrivacyPolicyAlert()
    func showRegistrationFailedAlert()
    func showRegistrationSuccessAlert()
}

class RegisterViewModel {
    var email = ""
    var password = ""
    var phoneNumber = ""
    
    var isPrivacyChecked = false
    
    var firebaseManager: FirebaseManagerProtocol
    
    weak var delegate: RegisterViewModelDelegate?
    
    init(email: String = "", password: String = "", phoneNumber: String = "", isPrivacyChecked: Bool = false, firebaseManager: FirebaseManagerProtocol, delegate: RegisterViewModelDelegate? = nil) {
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.isPrivacyChecked = isPrivacyChecked
        self.firebaseManager = firebaseManager
        self.delegate = delegate
    }
    
    convenience init(firebaseManager: FirebaseManagerProtocol) {
        self.init(email: "", password: "", phoneNumber: "", isPrivacyChecked: false, firebaseManager: firebaseManager, delegate: nil)
    }
    
    // MARK: Logic
    
    private func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidFieldsLength() -> Bool {
        return !email.isEmpty && !password.isEmpty && !phoneNumber.isEmpty
    }
    
    // MARK: Presentation
    
    func didTapRegister() {
        guard isValidFieldsLength() else {
            delegate?.showEmptyFieldsAlert()
            return
        }
        
        guard isValidEmail() else {
            delegate?.showEmailWrongFormatAlert()
            return 
        }
        
        guard isPrivacyChecked else {
            delegate?.showPrivacyPolicyAlert()
            return
        }
        
        firebaseManager.registerWith(email: email, password: password) {
            self.delegate?.showRegistrationSuccessAlert()
        } fail: {
            self.delegate?.showRegistrationFailedAlert()
        }
    }
}
