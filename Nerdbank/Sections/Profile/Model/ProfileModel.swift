//
//  ProfileMOdel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 04/11/22.
//

import VFNetwork
import Foundation

struct ProfileResponse: VCodable {
    var id: UUID?
    var fullName: String?
    var email: String?
    var isAdmin: Bool?
    var bankAccount: AccountRepresentable?
}

struct AccountRepresentable: VCodable {
    var agency: Int64
    var bankName: String
    var number: Int64
    var id: UUID?
    var bankNumber: Int64
    var digit: Int64

    init(agency: Int64, bankName: String, number: Int64, id: UUID?, bankNumber: Int64, digit: Int64) {
        self.agency = agency
        self.bankName = bankName
        self.number = number
        self.id = id
        self.bankNumber = bankNumber
        self.digit = digit
    }
}
