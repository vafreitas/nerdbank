//
//  WelcomeView.swift
//  Nerdbank
//
//  Created by Victor Freitas on 21/08/23.
//

import SwiftUI
import UIKit
import UICodeKit

class WelcomeView: BaseView {
    
    // MARK: UI Actions
    
    var signInAction: UICodeDefaultAction?
    var signUpAction: UICodeDefaultAction?
    
    // MARK: UI Components
    
    private lazy var titleLabel = UILabel() .. {
        $0.text = "Nerd Bank"
        $0.font = .boldSystemFont(ofSize: 34)
    }
    
    private lazy var subtitleLabel = UILabel() .. {
        $0.text = "Everything you need is here"
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 28, weight: .semibold)
        
    }
    
    private lazy var mainImage = UIImageView() .. {
        $0.image = UIImage(named: "welcome_ilust")
    }
    
    private lazy var signInButton = UIButton() .. {
        $0.setTitle("Sign in", for: .normal)
        $0.backgroundColor = UIColor(hexString: "#149E64")
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        $0.height(50)
        $0.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    private lazy var signUpButton = UIButton() .. {
        $0.setTitle("Sign Up Now", for: .normal)
        $0.backgroundColor = UIColor(hexString: "#0D5934")
        $0.layer.cornerRadius = 10
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        $0.height(50)
        $0.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    private lazy var copyrightLabel = UILabel() .. {
        $0.text = "Nerdbank all rights reserved 2023"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
        $0.height(40)
        $0.textAlignment = .center
    }
    
    override func body() -> UICodeView? {
        UIStack(axis: .vertical) {
            UIStack(axis: .vertical) {
                titleLabel
                subtitleLabel
            }
            .padding(.horizontal(18), .bottom(40))
            
            mainImage
                .padding(.bottom(60))
            
            UIStack(axis: .vertical) {
                signInButton
                signUpButton
            }
            .padding(.horizontal(24))
            
            copyrightLabel
        }
        .padding(.vertical(24))
        .. {
            $0.backgroundColor = .systemBackground
        }
    }
    
    // MARK: Func Actions
    
    @objc func signInTapped() {
        signInAction?()
    }
    
    @objc func signUpTapped() {
        signUpAction?()
    }
}


// MARK: Preview

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeViewController(viewModel: .init()).toPreview()
    }
}
