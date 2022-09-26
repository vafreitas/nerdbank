//
//  TransactionsModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import VFNetwork

struct TransactionsModel: VCodable {
    var transactions: [TransactionModel]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.transactions = try container.decode([TransactionModel].self)
    }
}

struct TransactionModel: VCodable {
    var transactionDate: String
    var senderId: String
    var value: Double
    var recipientName: String
    var transactionType: String
    var recipientId: String
    var senderName: String
    
    enum CodingKeys: String, CodingKey {
        case transactionDate = "transaction_date"
        case senderId = "sender_id"
        case value
        case recipientName = "recipient_name"
        case transactionType = "transaction_type"
        case recipientId = "recipient_id"
        case senderName = "sender_name"
    }
}
