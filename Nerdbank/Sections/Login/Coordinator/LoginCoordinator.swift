//
//  LoginCoordinator.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import XCoordinator
import UIKit

enum LoginRoute: Route {
    case root
    case home
    case forget
    case signIn
}

class LoginCoordinator: NavigationCoordinator<LoginRoute> {
    init(rootViewController: UINavigationController) {
        super.init(rootViewController: rootViewController)
    }
    
    override func prepareTransition(for route: LoginRoute) -> NavigationTransition {
        switch route {
        case .root:
            let viewModel = LoginViewModel(router: unownedRouter)
            let viewController = LoginViewController(viewModel: viewModel)
            return .push(viewController)
        case .home:
            let coordinator = HomeTabBarCoordinator()
            return .presentFullScreen(coordinator)
        case .signIn:
            return .push(UIViewController())
        case .forget:
            return .push(UIViewController())
        }
    }
}
