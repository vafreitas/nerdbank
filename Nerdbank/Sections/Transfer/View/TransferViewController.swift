//
//  TransferViewController.swift
//  Nerdbank
//
//  Created by Victor Freitas on 22/04/23.
//

import UIKit

class TransferViewController: BaseViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newTansferButton: UIButton!
    
    // MARK: Properties
    
    var viewModel: TransferViewModel
    
    // MARK: Initializer
    
    init(viewModel: TransferViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transferir"
        navigationIsHidden = false
        setupTableView()
        setupButton()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(.init(nibName: "TransferFavoriteOptionCell", bundle: .main),
                           forCellReuseIdentifier: "TransferFavoriteOptionCell")
        tableView.register(.init(nibName: "TransferRecentOptionCell", bundle: .main),
                           forCellReuseIdentifier: "TransferRecentOptionCell")
    }
    
    func setupButton() {
        newTansferButton.layer.cornerRadius = 10
        newTansferButton.layer.masksToBounds = true
    }
    
    // MARK: Actions
    
    @IBAction func newTransferTapped(_ sender: Any) {
        
    }
}

// MARK: UITableViewDelegate

extension TransferViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.model.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.model.sections[indexPath.section].options[indexPath.row]
        let section = viewModel.model.sections[indexPath.section]
        
        switch section.type {
        case .recents:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransferRecentOptionCell", for: indexPath) as? TransferRecentOptionCell else { return .init() }
            cell.setup(section.options)
            return cell
        case .favorite:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransferFavoriteOptionCell", for: indexPath) as? TransferFavoriteOptionCell else { return .init() }
            cell.setup(item)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0,
                                  width: headerView.frame.width - 10,
                                  height: headerView.frame.height)
        label.text = viewModel.model.sections[section].title
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.textColor = UIColor(named: "transfer-fav-text")
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}
