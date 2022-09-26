//
//  HomeAPI.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import VFNetwork

enum HomeAPI {
    case balance
    case transactions
    case shortcuts
}

extension HomeAPI: APIBuilder {
    var path: URLPath {
        switch self {
        case .balance:
            return .plain("bagion/balance")
        case .transactions:
            return .plain("bagion/transactions")
        case .shortcuts:
            return .plain("home/shortcuts")
        }
    }
    
    var httpMethod: HTTPMethods {
        .get
    }
    
    var headers: HTTPHeader {
        .header("Authorization", "Bearer " + (Keychain.shared.get("user", LoginResponseModel.self)?.accessToken ?? ""))
    }
    
    var task: HTTPTask {
        .request
    }
}
