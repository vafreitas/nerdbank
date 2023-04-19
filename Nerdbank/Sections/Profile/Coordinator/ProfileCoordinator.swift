//
//  ProfileCoordinator.swift
//  Nerdbank
//
//  Created by Victor Freitas on 15/04/23.
//

import XCoordinator
import UIKit

enum ProfileRoute: Route {
    case profile
    case logout
}

class ProfileCoordinator: NavigationCoordinator<ProfileRoute> {
    
    // MARK: Initializer
    
    init() {
        super.init(initialRoute: .profile)
    }
    
    override func prepareTransition(for route: ProfileRoute) -> NavigationTransition {
        switch route {
        case .profile:
            let viewModel = ProfileViewModel(router: weakRouter)
            let profileVC = ProfileViewController(viewModel: viewModel)
            return .set([profileVC])
        case .logout:
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = WelcomeCoordinator().rootViewController
                window.makeKeyAndVisible()
            }
            return .none()
        }
    }
}
