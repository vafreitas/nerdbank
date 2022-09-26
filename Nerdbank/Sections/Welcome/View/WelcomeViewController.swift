//
//  WelcomeViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import UIKit

class WelcomeViewController: UIViewController {

    let viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func enterTapped(_ sender: Any) {
        viewModel.goToSignIn()
    }
    
    @IBAction func singUpTapped(_ sender: Any) {
        
    }
}
