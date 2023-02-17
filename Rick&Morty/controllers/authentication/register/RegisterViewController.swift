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
        
        scrollView.contentInset = view.safeAreaInsets
        
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
        let alert = UIAlertController(title: "Oops..", message: "Make sure to fill all the required fields.", preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAlertAction)
        
        present(alert, animated: true)
    }
    
    func showEmailWrongFormatAlert() {
        let alert = UIAlertController(title: "Oops..", message: "Make sure to provide a valid email format.", preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAlertAction)
        
        present(alert, animated: true)
    }
    
    func showPrivacyPolicyAlert() {
        let alert = UIAlertController(title: "Oops..", message: "Make sure to check the privacy policy and service terms field.", preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAlertAction)
        
        present(alert, animated: true)
    }
    
    func showRegistrationFailedAlert() {
        let alert = UIAlertController(title: "Oops..", message: "Registration failed.", preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAlertAction)
        
        present(alert, animated: true)
    }
    
    func showRegistrationSuccessAlert() {
        let alert = UIAlertController(title: "Yaay", message: "Registration complete. Tap OK to proceed to sign in screen.", preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.presentSignInController()
        }
        alert.addAction(okAlertAction)
        
        present(alert, animated: true)
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
