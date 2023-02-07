//
//  ProfileAPI.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 04/11/22.
//

import VFNetwork

enum ProfileAPI {
    case me
}

extension ProfileAPI: APIBuilder {
    var path: URLPath {
        .plain("auth/me")
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
