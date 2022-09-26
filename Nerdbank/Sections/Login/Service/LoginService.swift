//
//  LoginService.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import VFNetwork

class LoginService: RequestService<LoginAPI> {
    func auth(_ model: LoginRequestModel, _ completion: @escaping (Result<LoginResponseModel, Error>) -> Void) {
        execute(.auth(model), responseType: LoginResponseModel.self, completion: completion)
    }
}
