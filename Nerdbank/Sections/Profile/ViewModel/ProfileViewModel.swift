//
//  ProfileViewModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 04/11/22.
//

import Foundation
import XCoordinator

protocol ProfileViewModelViewDelegate: AnyObject {
    func profileViewModelMeSuccess(_ viewModel: ProfileViewModel)
    func profileViewModelMeFailure(_ viewModel: ProfileViewModel, error: Error)
}

class ProfileViewModel {
    
    // MARK: Properties
    
    let service: ProfileService
    var model: ProfileResponse
    var menu: ProfileMenuOptions
    var router: WeakRouter<ProfileRoute>
    
    weak var delegate: ProfileViewModelViewDelegate?
    
    // MARK: Initializer
    
    init(model: ProfileResponse = .init(), service: ProfileService = .init(), router: WeakRouter<ProfileRoute>) {
        self.service = service
        self.model = model
        self.router = router
        self.menu = .init(options: [
            .init(title: "Informações pessoais", icon: "profile_menu_info_ico", action: .person),
            .init(title: "Segurança", icon: "profile_menu_sec_ico", action: .security),
            .init(title: "Sair", icon: "profile_menu_logout_ico", action: .logout)
        ])
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
    
    func logout() {
        router.trigger(.logout)
    }
}
