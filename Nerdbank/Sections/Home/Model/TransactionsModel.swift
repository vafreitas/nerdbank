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
    var sections: [Section]?
}

struct Section: VCodable {
    var title: String
    var transactions: [Transaction]?
}

struct Transaction: VCodable {
    var senderName: String
    var transactionDate: String
    var recipientName: String
    var transactionType: String
    var formattedValue: String
    var movementType: String
    var formattedDate: String
    var value: Double
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case formattedDate = "formatted_date"
        case formattedValue = "formatted_value"
        case transactionDate = "transaction_date"
        case movementType = "movement_type"
        case value, icon
        case recipientName = "recipient_name"
        case transactionType = "transaction_type"
        case senderName = "sender_name"
    }
}
