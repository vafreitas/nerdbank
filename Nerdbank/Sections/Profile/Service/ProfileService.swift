//
//  ProfileService.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 04/11/22.
//

import VFNetwork

class ProfileService: RequestService<ProfileAPI> {
    func getMe(_ completion: @escaping (Result<ProfileResponse, Error>) -> Void) {
        execute(.me, responseType: ProfileResponse.self, completion: completion)
    }
    
    func uploadImage(model: ProfileRequest, completion: @escaping (Result<ProfileUploadResponse, Error>) -> Void) {
        execute(.upload(model, model.data.count), responseType: ProfileUploadResponse.self, completion: completion)
    }
}
