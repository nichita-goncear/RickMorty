//
//  SignInViewModel.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation

protocol SignInViewModelDelegate: AnyObject {
    func showEmptyFieldsAlert()
    func showEmailWrongFormatAlert()
    func showSignInFailure()
    func presentRegistrationViewController()
    func presentHomeViewController()
}

class SignInViewModel {
    var email = ""
    var password = ""
    
    weak var delegate: SignInViewModelDelegate?
    
    var firebaseManager: FirebaseManagerProtocol
    
    init(email: String = "", password: String = "", phoneNumber: String = "", firebaseManager: FirebaseManagerProtocol, delegate: SignInViewModelDelegate? = nil) {
        self.email = email
        self.password = password
        self.firebaseManager = firebaseManager
        self.delegate = delegate
    }
    
    convenience init(firebaseManager: FirebaseManagerProtocol) {
        self.init(email: "", password: "", firebaseManager: firebaseManager, delegate: nil)
    }
    
    // MARK: Logic
    
    private func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidFieldsLength() -> Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    // MARK: Presentation
    
    func didTapSignIn() {
        guard isValidFieldsLength() else {
            delegate?.showEmptyFieldsAlert()
            return 
        }
        
        guard isValidEmail() else {
            delegate?.showEmailWrongFormatAlert()
            return
        }
        
        firebaseManager.signInWith(email: email, password: password) {
            self.delegate?.presentHomeViewController()
        } fail: {
            self.delegate?.showSignInFailure()
        }
    }
    
    func didTapRegister() {
        delegate?.presentRegistrationViewController()
    }
}
