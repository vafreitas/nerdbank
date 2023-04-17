//
//  HomeModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import Foundation
import UIKit

struct HomeModel {
    var balance: BalanceModel?
    var extract: TransactionModel?
    var menuOptions: [HomeMenuModel]?
}

struct HomeMenuModel {
    var image: UIImage?
    var title: String
    var type: HomeMenuType
}

enum HomeMenuType {
    case transfer
    case payment
    case cashin
}
