//
//  LoginViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import UIKit
import KeychainSwift

class LoginViewController: BaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var passwordTextField: NBTextField!
    @IBOutlet weak var emailTextField: NBTextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: Properties
    
    var viewModel: LoginViewModel
    
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
    }
        
    // MARK: Actions
    
    @IBAction func loginTapped(_ sender: Any) {
        let model = LoginRequestModel(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        isLoading = true
        viewModel.authenticate(model)
    }
    
    @IBAction func forgetPasswordTapped(_ sender: Any) {
        
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
