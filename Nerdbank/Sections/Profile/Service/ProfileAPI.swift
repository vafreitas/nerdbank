//
//  ProfileAPI.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 04/11/22.
//

import VFNetwork

enum ProfileAPI {
    case me
    case upload(ProfileRequest, Int)
    case profileURL
}

extension ProfileAPI: APIBuilder {
    var path: URLPath {
        switch self {
        case .me:
            return .plain("auth/me")
        case .upload:
            return .plain("bagion/upload")
        case .profileURL:
            return .plain("bagion/profile-image")
        }
        
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .me, .profileURL:
            return .get
        case .upload:
            return .post
        }
    }
    
    var headers: HTTPHeader {
        switch self {
        case .me, .profileURL:
            return .bearer((Keychain.shared.get("user", LoginResponseModel.self)?.accessToken ?? ""))
        case let .upload(_, size):
            return .custom([
                .bearer((Keychain.shared.get("user", LoginResponseModel.self)?.accessToken ?? "")),
                .multipart,
                .lenght(size)
            ])
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .me, .profileURL:
            return .request
        case let .upload(model, _):
            return .requestBody(parameters: [
                "data": model.data,
                "filename": model.filename
            ])
        }
    }
}
