//
//  ProfileViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 04/11/22.
//

import UIKit
import SkeletonView
import Toast

class ProfileViewController: BaseViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var agencyLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bankInfoView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
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
        setupView()
        setupTableView()
        fetch()
    }
    
    func setupView() {
        title = "Perfil"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        bankInfoView.layer.cornerRadius = 10
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        profileImageView.layer.borderWidth = 0.2
        
        
        let image = traitCollection.userInterfaceStyle == .dark ? UIImage(named: "theme_sun_ico") : UIImage(named: "theme_moon_ico")
        navigationItem.rightBarButtonItem = .init(image: image,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(changeTheme))
    }
    
    @objc func changeTheme() {
        let window = UIApplication.shared.keyWindow
        let interfaceStyle = window?.overrideUserInterfaceStyle
        
        if interfaceStyle == .light {
            window?.overrideUserInterfaceStyle = .dark
            navigationItem.rightBarButtonItem?.image = UIImage(named: "theme_sun_ico")
        } else {
            window?.overrideUserInterfaceStyle = .light
            navigationItem.rightBarButtonItem?.image = UIImage(named: "theme_moon_ico")
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "ProfileMenuCell", bundle: .main), forCellReuseIdentifier: "ProfileMenuCell")
    }
    
    func fetch() {
        usernameLabel.showAnimatedGradientSkeleton()
        emailLabel.showAnimatedGradientSkeleton()
        agencyLabel.showAnimatedGradientSkeleton()
        accountLabel.showAnimatedGradientSkeleton()
        bankLabel.showAnimatedGradientSkeleton()
        viewModel.fetchMe()
    }
    
    func setInfo() {
        let user = viewModel.model
        usernameLabel.text = "\(user.fullName ?? "NA")"
        emailLabel.text = user.email
        agencyLabel.text = "\(user.bankAccount?.agency ?? 0)"
        accountLabel.text = "\(user.bankAccount?.number ?? 0)-\(user.bankAccount?.digit ?? 0)"
        bankLabel.text = "\(user.bankAccount?.bankName ?? "NA") - \(user.bankAccount?.bankNumber ?? 0)"
    }
    
    @IBAction func copyToClipboard(_ sender: Any) {
        let text =  """
            Estes são meus dados do Nerdbank. \n
            Conta: \(self.accountLabel.text ?? "")
            Agência: \(self.agencyLabel.text ?? "")
            Banco: \(self.bankLabel.text ?? "")
            """
        let alert = UIAlertController(title: "Dados Bancarios", message: "Oque deseja fazer?", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Copiar", style: .default) { _ in
            UIPasteboard.general.string = text
            var style = ToastStyle()
            style.backgroundColor = UIColor(named: "profile_copy_bg") ?? .init()
            style.titleColor = UIColor(named: "profile_username") ?? .init()
            style.imageSize = .init(width: 24, height: 24)
            style.titleAlignment = .center
            ToastManager.shared.style = style
            var image = UIImage(named: "toast_success_ico")
            image?.withTintColor(.init(named: "profile_menu_ico") ?? .init())
            self.view.makeToast(nil, duration: 2.0, title: "Dados Copiados!", image: image)
        }
        
        let action2 = UIAlertAction(title: "Compartilhar", style: .default) { _ in
            self.share(text: text)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(.init(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
    
    func share(text: String) {
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: UITableViewDelegate

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.menu.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMenuCell", for: indexPath) as? ProfileMenuCell else { return .init() }
        cell.setup(viewModel.menu.options[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = viewModel.menu.options[indexPath.row].action
        switch action {
        case .person:
            break
        case .security:
            break
        case .logout:
            let alert = UIAlertController(title: "Deseja mesmo sair?", message: "Você está deslogando de sua conta", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Sim", style: .default) { _ in
                Keychain.shared.clear()
                self.viewModel.logout()
            }
            
            let no = UIAlertAction(title: "Não", style: .destructive)
            alert.addAction(yes)
            alert.addAction(no)
            present(alert, animated: true)
        }
    }
}



// MARK: ProfileViewModel Delegate

extension ProfileViewController: ProfileViewModelViewDelegate {
    func profileViewModelMeSuccess(_ viewModel: ProfileViewModel) {
        usernameLabel.hideSkeleton()
        emailLabel.hideSkeleton()
        agencyLabel.hideSkeleton()
        accountLabel.hideSkeleton()
        bankLabel.hideSkeleton()
        setInfo()
    }
    
    func profileViewModelMeFailure(_ viewModel: ProfileViewModel, error: Error) {
        usernameLabel.hideSkeleton()
        emailLabel.hideSkeleton()
        agencyLabel.hideSkeleton()
        accountLabel.hideSkeleton()
        bankLabel.hideSkeleton()
        print("Failed Me!")
    }
}
