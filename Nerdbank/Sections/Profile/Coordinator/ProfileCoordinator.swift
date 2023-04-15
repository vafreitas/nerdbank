//
//  ProfileCoordinator.swift
//  Nerdbank
//
//  Created by Victor Freitas on 15/04/23.
//

import XCoordinator

enum ProfileRoute: Route {
    case profile
}

class ProfileCoordinator: NavigationCoordinator<ProfileRoute> {
    
    // MARK: Initializer
    
    init() {
        super.init(initialRoute: .profile)
    }
    
    override func prepareTransition(for route: ProfileRoute) -> NavigationTransition {
        switch route {
        case .profile:
            let viewModel = ProfileViewModel()
            let profileVC = ProfileViewController(viewModel: viewModel)
            return .set([profileVC])
        }
    }
}
