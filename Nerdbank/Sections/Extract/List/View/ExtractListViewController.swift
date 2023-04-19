//
//  ExtractViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 17/04/23.
//

import UIKit

class ExtractListViewController: BaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    var viewModel: ExtractListViewModel
    
    // MARK: Initializer
    
    init(viewModel: ExtractListViewModel = .init()) {
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
        title = "Extrato"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "TransactionTableViewCell",
                                             bundle: Bundle.main), forCellReuseIdentifier: "TransactionTableViewCell")
    }
    
    func fetch() {
        viewModel.fetchlist()
    }
}

// MARK: TableViewDelegate

extension ExtractListViewController: UITableViewDelegate, UITableViewDataSource {
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
        viewModel.model.extract?.sections?.count ?? 3
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

// MARK: Extract List View Delegate

extension ExtractListViewController: ExtractListViewDelegate {
    func extractListViewModelTransactionSuccess(_ viewModel: ExtractListViewModel) {
        tableView.reloadData()
    }
    
    func extractListViewModelTransactionFailure(_ viewModel: ExtractListViewModel, error: Error) {
        
    }
}
