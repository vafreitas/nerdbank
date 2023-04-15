//
//  ProfileViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 04/11/22.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var agencyLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    
    // MARK: Properties
    
    var viewModel: ProfileViewModel!
    
    // MARK: Initializer
    
    init(viewModel: ProfileViewModel) {
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
        title = "Perfil"
        fetch()
    }
    
    func fetch() {
        viewModel.fetchMe()
    }
    
    func setInfo() {
        let user = viewModel.model
        usernameLabel.text = "Olá, \(user.fullName ?? "NA")"
        emailLabel.text = user.email
        agencyLabel.text = "Agencia: \(user.bankAccount?.agency ?? 0)"
        accountLabel.text = "Conta: \(user.bankAccount?.number ?? 0)-\(user.bankAccount?.digit ?? 0)"
        bankLabel.text = "Banco: \(user.bankAccount?.bankName ?? "NA") - \(user.bankAccount?.bankNumber ?? 0)"
    }
}

// MARK: ProfileViewModel Delegate

extension ProfileViewController: ProfileViewModelViewDelegate {
    func profileViewModelMeSuccess(_ viewModel: ProfileViewModel) {
        print("Success Me!")
        setInfo()
    }
    
    func profileViewModelMeFailure(_ viewModel: ProfileViewModel, error: Error) {
        print("Failed Me!")
    }
}
