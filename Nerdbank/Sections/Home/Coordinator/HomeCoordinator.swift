//
//  HomeCoordinator.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import XCoordinator
import UIKit

enum HomeRoute: Route {
    case home
    case profile
    case logout
}

class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    init(rootViewController: UINavigationController? = nil) {
        if let rootViewController = rootViewController {
            super.init(rootViewController: rootViewController, initialRoute: .home)
        } else {
            super.init(initialRoute: .home)
        }
    }
    
    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .home:
            let viewModel = HomeViewModel(router: weakRouter)
            let viewController = HomeViewController(viewModel: viewModel)
            return .set([viewController])
        case .profile:
            let viewModel = ProfileViewModel()
            let viewController = ProfileViewController(viewModel: viewModel)
            return .push(viewController)
        case .logout:
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = WelcomeCoordinator().rootViewController
                window.makeKeyAndVisible()
            }
            return .none()
        }
    }
}
