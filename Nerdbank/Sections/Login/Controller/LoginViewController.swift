//
//  LoginViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import UIKit
import KeychainSwift

class LoginViewController: BaseViewController {
    
    // MARK: Properties
    
    var viewModel: LoginViewModel
    var rootView = LoginView()
    override func loadView() {
        view = rootView
    }
    
    // MARK: Initializer
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    func setupActions() {
        rootView.enterAction = {
            self.loginTapped()
        }
    }
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            rootView.emailTextField.text = "vitoralves59@gmail.com"
            rootView.passwordTextField.text = "the.pass"
        }
    }
        
    // MARK: Actions
    
    func loginTapped() {
        let model = LoginRequestModel(email: rootView.emailTextField.text ?? "", password: rootView.passwordTextField.text ?? "")
        isLoading = true
        viewModel.authenticate(model)
    }
    
    func forgetPasswordTapped(_ sender: Any) {
        
    }
}

// MARK: Login View Model Delegate View

extension LoginViewController: LoginViewModelViewDelegate {
    func loginViewModelSuccess(_ viewModel: LoginViewModel) {
        isLoading = false
        viewModel.goToHome()
    }
    
    func loginViewModelFailure(_ viewModel: LoginViewModel) {
        isLoading = false
    }
}
