//
//  LoginAPI.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import VFNetwork

enum LoginAPI {
    case auth(LoginRequestModel)
    case refreshToken(UserRefreshTokenRequest)
}

extension LoginAPI: APIBuilder {
    var path: URLPath {
        switch self {
        case .auth:
            return .plain("auth/login")
        case .refreshToken:
            return .plain("auth/accessToken")
        }
    }
    
    var httpMethod: HTTPMethods {
        .post
    }
    
    var headers: HTTPHeader {
        .empty
    }
    
    var task: HTTPTask {
        switch self {
        case let .auth(model):
            return .requestEncoder(model)
        case let .refreshToken(model):
            return .requestEncoder(model)
        }
    }
}
