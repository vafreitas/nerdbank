//
//  ProfileViewModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 04/11/22.
//

import Foundation

protocol ProfileViewModelViewDelegate: AnyObject {
    func profileViewModelMeSuccess(_ viewModel: ProfileViewModel)
    func profileViewModelMeFailure(_ viewModel: ProfileViewModel, error: Error)
}

class ProfileViewModel {
    
    // MARK: Properties
    
    let service: ProfileService
    var model: ProfileResponse
    
    weak var delegate: ProfileViewModelViewDelegate?
    
    // MARK: Initializer
    
    init(model: ProfileResponse = .init(), service: ProfileService = .init()) {
        self.service = service
        self.model = model
    }
    
    // MARK: API Methods
    
    func fetchMe() {
        service.getMe { result in
            switch result {
            case let .success(response):
                self.model = response
                self.delegate?.profileViewModelMeSuccess(self)
            case let .failure(error):
                self.delegate?.profileViewModelMeFailure(self, error: error)
            }
        }
    }
}
