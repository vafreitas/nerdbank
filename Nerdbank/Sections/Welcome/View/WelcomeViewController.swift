//
//  WelcomeViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import UIKit

class WelcomeViewController: BaseViewController {

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
    }
    
    // MARK: Actions

    @IBAction func enterTapped(_ sender: Any) {
        viewModel.goToSignIn()
    }
    
    @IBAction func singUpTapped(_ sender: Any) {
        
    }
}
