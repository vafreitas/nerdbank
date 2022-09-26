//
//  LoginViewModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import Foundation
import KeychainSwift
import XCoordinator

protocol LoginViewModelViewDelegate: AnyObject {
    func loginViewModelSuccess(_ viewModel: LoginViewModel)
    func loginViewModelFailure(_ viewModel: LoginViewModel)
}

class LoginViewModel {
 
    // MARK: Properties
    
    let model: LoginModel
    let router: UnownedRouter<LoginRoute>
    let service: LoginService
    let keychain = KeychainSwift()
    
    weak var delegate: LoginViewModelViewDelegate?
    
    // MARK: Initializer
    
    init(model: LoginModel = .init(),
         service: LoginService = .init(),
         router: UnownedRouter<LoginRoute>) {
        self.model = model
        self.service = service
        self.router = router
    }
    
    // MARK: API Functions
    
    func authenticate(_ model: LoginRequestModel) {
        service.auth(model) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                Keychain.shared.set("user", response)
                self.delegate?.loginViewModelSuccess(self)
            case let .failure(error):
                print(error)
                self.delegate?.loginViewModelFailure(self)
            }
        }
    }
    
    func goToHome() {
        router.trigger(.home)
    }
}
