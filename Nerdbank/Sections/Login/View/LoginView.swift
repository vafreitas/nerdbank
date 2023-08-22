//
//  LoginView.swift
//  Nerdbank
//
//  Created by Victor Freitas on 20/07/23.
//

import UICodeKit
import UIKit
import SwiftUI

class LoginView: BaseView {
    
    // MARK: Actions
    
    var enterAction: UICodeDefaultAction?
    
    // MARK: Components
    
    lazy var emailTextField = NBTextField() .. {
        $0.placeholder = "Email"
        $0.smallPlaceholderPadding = 10
        $0.separatorBottomPadding = 1
        $0.separatorLineViewColor = .clear
        $0.smallPlaceholderColor = .lightGray
        $0.placeholderColor = .lightGray
        $0.height(48)
        $0.textColor = UIColor(named: "login_text")
        $0.autocapitalizationType = .none
    }
    
    lazy var passwordTextField = NBTextField() .. {
        $0.placeholder = "Senha"
        $0.textColor = UIColor(named: "login_text")
        $0.isSecureTextEntry = true
        $0.smallPlaceholderPadding = 10
        $0.separatorBottomPadding = 1
        $0.separatorLineViewColor = .clear
        $0.smallPlaceholderColor = .lightGray
        $0.height(48)
        $0.placeholderColor = .lightGray
        $0.autocapitalizationType = .none
    }
    
    lazy var textFieldStack = UIStack(axis: .vertical, spacing: 24) {
        emailTextField
        passwordTextField
    }
    
    lazy var enterButton = UIButton(type: .custom) .. {
        $0.setTitle("Entrar", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hexString: "149E64")
        $0.height(48)
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        $0.addTarget(self, action: #selector(enterTapped), for: .touchUpInside)
    }
    
    lazy var forgetButton = UIButton() .. {
        $0.setTitle("Esqueci minha senha", for: .normal)
        $0.setTitleColor(UIColor(named: "login_forget"), for: .normal)
    }
    
    // MARK: Body
    
    override func body() -> UICodeView? {
        UIStack(axis: .vertical) {
            textFieldStack
            
            UIStack(axis: .vertical) {
                enterButton
                forgetButton
            }.padding(.top(24))
            
            UISpacer()
        }
        .padding(.horizontal(16), .top(24))
        .. {
            $0.backgroundColor = UIColor(named: "home_bg")
        }
    }
    
    // MARK: Actions
    
    @objc func enterTapped() {
        enterAction?()
    }
}

// MARK: Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewController(viewModel: .init()).toPreview()
    }
}
