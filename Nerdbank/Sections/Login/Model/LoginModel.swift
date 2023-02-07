//
//  LoginModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import VFNetwork

struct LoginModel {
    
}

struct LoginRequestModel: VCodable {
    var email: String
    var password: String
}

struct LoginResponseModel: VCodable {
    var accessToken: String
    var user: UserResponse
    var refreshToken: String
}

struct UserResponse: VCodable {
    var email: String
    var id: String
    var fullName: String
    var isAdmin: Bool
}

struct UserRefreshTokenRequest: VCodable {
    var refreshToken: String
}

struct UserRefreshTokenResponse: VCodable {
    var refreshToken: String
    var accessToken: String
}
