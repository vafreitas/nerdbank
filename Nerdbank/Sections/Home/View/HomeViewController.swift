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
    
    // MARK: Properties
    
    let viewModel: HomeViewModel
    let dispatchGroup = DispatchGroup()
    
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
    }
    
    func setupTableView() {
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        transactionsTableView.register(.init(nibName: "TransactionTableViewCell",
                                             bundle: Bundle.main), forCellReuseIdentifier: "TransactionTableViewCell")
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
    
    @IBAction func openProfile(_ sender: Any) {
        let bottomSheet = UIAlertController(title: "Options", message: "Choose", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
            Keychain.shared.clear()
            self.viewModel.logout()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        bottomSheet.addAction(logoutAction)
        bottomSheet.addAction(cancelAction)
        navigationController?.present(bottomSheet, animated: true)
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
        dispatchGroup.leave()
    }
    
    func HomeViewModelBalanceFailure(_ viewModel: HomeViewModel, error: Error) {
        print(error)
    }
}
