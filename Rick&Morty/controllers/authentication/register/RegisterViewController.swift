//
//  RegisterViewController.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 16.02.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registrationFieldsView: RegistrationFieldsView!
    @IBOutlet weak var checkmarkTextView: CheckmarkTextView!
    
    var viewModel = RegisterViewModel(firebaseManager: FirebaseManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
        setupKeyboardAvoidance()
    }
    
    private func setupView() {
        viewModel.delegate = self
        registrationFieldsView.delegate = self
        checkmarkTextView.delegate = self
        
        imageView.layer.shadowColor = UIColor.green.cgColor
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 20
        imageView.layer.shadowOpacity = 0.2
    }
    
    private func setupKeyboardAvoidance() {
        scrollView.keyboardDismissMode = .interactive

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
    }
    
    
    @IBAction func didTapRegister(_ sender: Any) {
        viewModel.didTapRegister()
    }
    
}

extension RegisterViewController: RegistrationFieldsViewDelegate {
    func didChangeEmail(currentValue: String) {
        viewModel.email = currentValue
    }
    
    func didChangePassword(currentValue: String) {
        viewModel.password = currentValue
    }
    
    func didChangePhoneNumber(currentValue: String) {
        viewModel.phoneNumber = currentValue
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func showEmptyFieldsAlert() {
        presentAlert(title: "Oops..", msg: "Make sure to fill all the required fields.")
    }
    
    func showEmailWrongFormatAlert() {
        presentAlert(title: "Oops..", msg: "Make sure to provide a valid email format.")
    }
    
    func showPrivacyPolicyAlert() {
        presentAlert(title: "Oops..", msg: "Make sure to check the privacy policy and service terms field.")
    }
    
    func showRegistrationFailedAlert() {
        presentAlert(title: "Oops..", msg: "Registration failed.")
    }
    
    func showRegistrationSuccessAlert() {
        presentAlert(title: "Yaay", msg: "Registration complete. Tap OK to proceed to sign in screen.", completion: presentSignInController)
    }
    
    func presentSignInController() {
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: CheckmarkTextViewDelegate {
    func didChangeState(currentState: Bool) {
        viewModel.isPrivacyChecked = currentState
    }
}
