//
//  ExtractAPI.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 17/04/23.
//

import VFNetwork

enum ExtractAPI {
    case transactions
}

extension ExtractAPI: APIBuilder {
    var path: URLPath {
        switch self {
        case .transactions:
            return .plain("bagion/transactions")
        }
    }
    
    var httpMethod: HTTPMethods {
        .get
    }
    
    var headers: HTTPHeader {
        .bearer(Keychain.shared.get("user", LoginResponseModel.self)?.accessToken ?? "")
    }
    
    var task: HTTPTask {
        .request
    }
}
