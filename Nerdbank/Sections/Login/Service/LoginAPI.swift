//
//  LoginAPI.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import VFNetwork

enum LoginAPI {
    case auth(LoginRequestModel)
}

extension LoginAPI: APIBuilder {
    var path: VFNetwork.URLPath {
        .plain("auth/login")
    }
    
    var httpMethod: VFNetwork.HTTPMethods {
        .post
    }
    
    var headers: VFNetwork.HTTPHeader {
        .empty
    }
    
    var task: VFNetwork.HTTPTask {
        switch self {
        case let .auth(model):
            return .requestEncoder(model)
        }
    }
}
