//
//  TransferModel.swift
//  Nerdbank
//
//  Created by Victor Freitas on 22/04/23.
//

import Foundation

struct TransferModel {
    var sections: [TransferSections]
}

struct TransferSections {
    var title: String
    var options: [TransferOption]
    var type: TransferSectionType
}

struct TransferOption {
    var name: String
}

enum TransferSectionType {
    case recents
    case favorite
}
