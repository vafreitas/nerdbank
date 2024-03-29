//
//  HomeViewModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import Foundation
import XCoordinator

protocol HomeViewModelViewDelegate: AnyObject {
    func HomeViewModelBalanceSuccess(_ viewModel: HomeViewModel)
    func HomeViewModelBalanceFailure(_ viewModel: HomeViewModel, error: Error)
    func HomeViewModelTransactionsSuccess(_ viewModel: HomeViewModel)
    func HomeViewModelTransactionsFailure(_ viewModel: HomeViewModel, error: Error)
}

class HomeViewModel {
    
    // MARK: Properties
    
    var model: HomeModel
    let service: HomeService
    let router: WeakRouter<HomeRoute>?
    
    weak var delegate: HomeViewModelViewDelegate?
    
    // MARK: Initializer
    
    init(model: HomeModel = .init(), service: HomeService = .init(), router: WeakRouter<HomeRoute>? = nil) {
        self.model = model
        self.service = service
        self.router = router
        
        self.model.menuOptions = [
            .init(image: .init(named: "transfer_menu_ico"), title: "Transferir", type: .transfer),
            .init(image: .init(named: "cash_menu_ico"), title: "Depositar", type: .cashin),
            .init(image: .init(named: "currency_menu_ico"), title: "Pagar", type: .payment),
            .init(image: .init(named: "currency_menu_ico"), title: "Pagar", type: .payment)
            
        ]
    }
    
    func fetchBalance() {
        service.fetchBalance { result in
            switch result {
            case let .success(response):
                self.model.balance = response
                self.delegate?.HomeViewModelBalanceSuccess(self)
            case let .failure(error):
                self.delegate?.HomeViewModelBalanceFailure(self, error: error)
            }
        }
    }
    
    func fetchTransactions() {
        service.fetchTransactions { result in
            switch result {
            case let .success(response):
                self.model.extract = response
                self.delegate?.HomeViewModelTransactionsSuccess(self)
            case let .failure(error):
                self.delegate?.HomeViewModelTransactionsFailure(self, error: error)
            }
        }
    }
    
    // MARK: Routes
    
    func goToTransfer() {
        router?.trigger(.transfer)
    }
    
}
