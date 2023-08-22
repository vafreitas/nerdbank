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

    // MARK: Outlets
    
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
    var picker = UIImagePickerController()
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPicker))
    
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
        setupProfileView()
        bankInfoView.layer.cornerRadius = 10
        let image = traitCollection.userInterfaceStyle == .dark ? UIImage(named: "theme_sun_ico") : UIImage(named: "theme_moon_ico")
        navigationItem.rightBarButtonItem = .init(image: image,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(changeTheme))
    }
    
    func setupProfileView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        profileImageView.layer.borderWidth = 0.2
        profileImageView.addGestureRecognizer(tapGesture)
        loadImage()
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
    
    // MARK: Actions
    
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
            let image = UIImage(named: "toast_success_ico")
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
    
    func saveImage() {
        guard let data = profileImageView.image?.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "profile-image")
    }
    
    func loadImage() {
        guard let data = UserDefaults.standard.data(forKey: "profile-image") else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        profileImageView.image = image
    }
}

// MARK: UIImagePicker

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func openPicker() {
        let alert: UIAlertController = UIAlertController(title: "Qual opção deseja selecionar?",
                                                         message: nil,
                                                         preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        }
        
        let gallaryAction = UIAlertAction(title: "Galeria", style: .default) { _ in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        } else {
            let alertWarning = UIAlertView(title:"Atenção",
                                           message: "Você não tem acesso a camera!",
                                           delegate:nil, cancelButtonTitle:"Certo", otherButtonTitles:"")
            alertWarning.show()
        }
    }
    
    func openGallery() {
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        guard let imageData = image?.jpegData(compressionQuality: 0.8) else {
              return
        }
        
        viewModel.profileRequest.data = imageData
        viewModel.profileRequest.filename = "profile-picture"
        viewModel.uploadImage()
//        saveImage()
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
                self.resetDefaults()
                self.viewModel.logout()
            }
            
            let no = UIAlertAction(title: "Não", style: .destructive)
            alert.addAction(yes)
            alert.addAction(no)
            present(alert, animated: true)
        }
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
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
