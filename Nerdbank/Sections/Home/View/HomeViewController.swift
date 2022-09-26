//
//  HomeViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import UIKit
import SkeletonView

class HomeViewController: UIViewController {
    
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
        super.init(nibName: nil, bundle: nil)
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
        viewModel.fetchBalance()
        
        dispatchGroup.enter()
        balanceLabel.showAnimatedGradientSkeleton()
        viewModel.fetchTransactions()
        
        dispatchGroup.notify(queue: .main) {
            print("Services Finished")
        }
    }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as? TransactionTableViewCell,
              let transaction = viewModel.model.transactions?.transactions[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setup(transaction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.transactions?.transactions.count ?? 0
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
