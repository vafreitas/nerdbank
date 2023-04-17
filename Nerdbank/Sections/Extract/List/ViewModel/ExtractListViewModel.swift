//
//  ExtractViewModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 17/04/23.
//

import Foundation
import XCoordinator

protocol ExtractListViewDelegate: AnyObject {
    func extractListViewModelTransactionSuccess(_ viewModel: ExtractListViewModel)
    func extractListViewModelTransactionFailure(_ viewModel: ExtractListViewModel, error: Error)
}

class ExtractListViewModel {
    
    var model: ExtractModel
    let service: ExtractService
    let router: WeakRouter<ExtractRoute>?
    
    weak var delegate: ExtractListViewDelegate?
    
    init(model: ExtractModel = .init(), service: ExtractService = .init(), router: WeakRouter<ExtractRoute>? = nil) {
        self.model = model
        self.service = service
        self.router = router
    }
    
    // MARK: Services
    
    func fetchlist() {
        service.fetchTransactions { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(transactions):
                self.model.extract = transactions
                self.delegate?.extractListViewModelTransactionSuccess(self)
            case let .failure(error):
                debugPrint(error)
                self.delegate?.extractListViewModelTransactionFailure(self, error: error)
            }
        }
    }
}
