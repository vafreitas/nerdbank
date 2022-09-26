//
//  HomeService.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import VFNetwork

class HomeService: RequestService<HomeAPI> {
    func fetchBalance(_ completion: @escaping (Result<BalanceModel, Error>) -> Void) {
        execute(.balance, responseType: BalanceModel.self, completion: completion)
    }
    
    func fetchTransactions(_ completion: @escaping (Result<TransactionsModel, Error>) -> Void) {
        execute(.transactions, responseType: TransactionsModel.self, completion: completion)
    }
}
