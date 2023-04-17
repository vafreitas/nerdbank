//
//  ExtractService.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 17/04/23.
//

import VFNetwork

class ExtractService: RequestService<ExtractAPI> {
    func fetchTransactions(_ completion: @escaping (Result<TransactionModel, Error>) -> Void) {
        execute(.transactions, responseType: TransactionModel.self, completion: completion)
    }
}
