//
//  BalanceModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import VFNetwork

struct BalanceModel: VCodable {
    var id: String
    var balanceAvailable: Double
    var cashback: Double
    var balanceBlocked: Double
    
    enum CodingKeys: String, CodingKey {
        case id, cashback
        case balanceAvailable = "balance_available"
        case balanceBlocked = "balance_blocked"
    }
}
