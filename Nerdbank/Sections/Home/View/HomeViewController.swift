//
//  HomeViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import UIKit
import SkeletonView
    
class HomeViewController: BaseViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var shortcutCollectionView: UICollectionView!
    @IBOutlet weak var transactionsTableView: UITableView!
    @IBOutlet weak var eyeButton: UIButton!
    
    // MARK: Properties
    
    let viewModel: HomeViewModel
    let dispatchGroup = DispatchGroup()
    var balanceIsHidden: Bool = false
    
    // MARK: Initializer
    
    init(viewModel: HomeViewModel) {
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
        setupTableView()
        setupCollectionView()
        setupHeaderView()
        setupData()
        fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationIsHidden = true
    }
    
    func setupHeaderView() {
        headerView.roundCorners(radius: 20, corners: [.bottomLeft, .bottomRight])
        balanceLabel.layer.cornerRadius = 10
        balanceLabel.layer.masksToBounds = true
        changeVisibillity()
        changeIcon()
    }
    
    func setupTableView() {
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        transactionsTableView.register(.init(nibName: "TransactionTableViewCell",
                                             bundle: Bundle.main), forCellReuseIdentifier: "TransactionTableViewCell")
    }
    
    func setupCollectionView() {
        shortcutCollectionView.register(.init(nibName: "HomeCollectionCell", bundle: .main), forCellWithReuseIdentifier: "HomeCollectionCell")
        shortcutCollectionView.delegate = self
        shortcutCollectionView.dataSource = self
    }
    
    func setupData() {
        let user = Keychain.shared.get("user", LoginResponseModel.self)
        usernameLabel.text = "Olá, " + (user?.user.fullName ?? "NONAME")
    }
    
    func fetch() {
        dispatchGroup.enter()
        balanceLabel.showAnimatedGradientSkeleton()
        viewModel.fetchBalance()
        
        dispatchGroup.enter()
        viewModel.fetchTransactions()
        
        dispatchGroup.notify(queue: .main) {
            print("Services Finished")
        }
    }
    
    @IBAction func openNotifications(_ sender: Any) {
       
    }
    
    @IBAction func eyeTapped(_ sender: Any) {
        changeVisibillity()
    }
    
    func changeVisibillity() {
        balanceIsHidden = UserDefaults.standard.bool(forKey: "balance-hidden")
        if balanceIsHidden {
            eyeButton.setImage(UIImage(named: "home_eye_open"), for: .normal)
            balanceLabel.text = "                      "
            balanceLabel.backgroundColor = .lightGray
            UserDefaults.standard.set(false, forKey: "balance-hidden")
        } else {
            eyeButton.setImage(UIImage(named: "home_eye_close"), for: .normal)
            balanceLabel.text = "R$ " + String(describing: viewModel.model.balance?.balanceAvailable ?? 0)
            balanceLabel.backgroundColor = .clear
            UserDefaults.standard.set(true, forKey: "balance-hidden")
        }
    }
    
    func changeIcon() {
        balanceIsHidden = UserDefaults.standard.bool(forKey: "balance-hidden")
        let image = balanceIsHidden == true ? UIImage(named: "home_eye_open") : UIImage(named: "home_eye_close")
        eyeButton.setImage(image, for: .normal)
    }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as? TransactionTableViewCell else { return UITableViewCell() }
        
        if let transaction = viewModel.model.extract?.sections?[indexPath.section].transactions?[indexPath.row] {
            cell.hideSkeleton()
            cell.setup(transaction)
            return cell
        } else {
            cell.showSkeleton()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.model.extract?.sections?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.extract?.sections?[section].transactions?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.model.extract?.sections?[section].title ?? "N/A"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32.0
    }
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as? HomeCollectionCell else {
            return .init()
        }
        if let item = viewModel.model.menuOptions?[indexPath.row] {
            cell.setup(item)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.model.menuOptions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let option = viewModel.model.menuOptions?[indexPath.row] else { return }
        switch option.type {
        case .transfer:
            viewModel.goToTransfer()
        case .payment:
            debugPrint("Payment")
        case .cashin:
            debugPrint("Cashin")
        }
    }
}

// MARK: HomeViewModelDelegate

extension HomeViewController: HomeViewModelViewDelegate {
    func HomeViewModelTransactionsSuccess(_ viewModel: HomeViewModel) {
        transactionsTableView.reloadData()
        dispatchGroup.leave()
    }
    
    func HomeViewModelTransactionsFailure(_ viewModel: HomeViewModel, error: Error) {
        print(error)
    }
    
    func HomeViewModelBalanceSuccess(_ viewModel: HomeViewModel) {
        balanceLabel.hideSkeleton(transition: .crossDissolve(0.25))
        balanceLabel.text = "R$ " + String(describing: viewModel.model.balance?.balanceAvailable ?? 0)
        changeVisibillity()
        dispatchGroup.leave()
    }
    
    func HomeViewModelBalanceFailure(_ viewModel: HomeViewModel, error: Error) {
        changeVisibillity()
        print(error)
    }
}
