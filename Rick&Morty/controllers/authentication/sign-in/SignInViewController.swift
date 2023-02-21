//
//  SignInViewController.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signInFieldsView: SignInFieldsView!
    
    var viewModel = SignInViewModel(firebaseManager: FirebaseManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setup() {
        setupView()
        setupKeyboardAvoidance()
    }
    
    private func setupView() {
        viewModel.delegate = self
        signInFieldsView.delegate = self
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
    
    @IBAction func signInTapped(_ sender: Any) {
        viewModel.didTapSignIn()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        viewModel.didTapRegister()
    }
}

extension SignInViewController: SignInFieldsViewDelegate {
    func didChangeEmail(currentValue: String) {
        viewModel.email = currentValue
    }
    
    func didChangePassword(currentValue: String) {
        viewModel.password = currentValue
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func showEmptyFieldsAlert() {
        presentAlert(title: "Oops", msg: "Make sure to fill all the required fields.")
    }
    
    func showEmailWrongFormatAlert() {
        presentAlert(title: "Oops", msg: "Make sure to provide a valid email format.")
    }
    
    func showSignInFailure() {
        presentAlert(title: "Oops", msg: "Sign in failed.")
    }
    
    func presentRegistrationViewController() {
        let registrationViewController = RegisterViewController()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
    
    func presentHomeViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeNavController = storyboard.instantiateViewController(identifier: "HomeNavigationController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(homeNavController)
    }
}
