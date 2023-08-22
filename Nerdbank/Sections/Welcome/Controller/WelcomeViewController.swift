//
//  WelcomeViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    // MARK: Root View
    let rootView = WelcomeView()
    override func loadView() {
        view = rootView
    }

    // MARK: Properties
    
    let viewModel: WelcomeViewModel

    // MARK: Initializer
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    // MARK: Actions
    
    func setupActions() {
        rootView.signInAction = { [weak self] in
            self?.viewModel .goToSignIn()
        }
    }
}
