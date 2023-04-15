//
//  WelcomeCoordinator.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import XCoordinator
import UIKit

enum WelcomeRoute: Route {
    case root
    case home
    case login
    case signUp
}

class WelcomeCoordinator: NavigationCoordinator<WelcomeRoute> {
    let user = Keychain.shared.get("user", LoginResponseModel.self)
    
    init() {
        if user != nil {
            super.init(initialRoute: .home)
        } else {
            super.init(initialRoute: .root)
        }
    }
    
    override func prepareTransition(for route: WelcomeRoute) -> NavigationTransition {
        switch route {
        case .root:
            let viewModel = WelcomeViewModel(router: strongRouter)
            let viewController = WelcomeViewController(viewModel: viewModel)
            return .set([viewController])
        case .home:
            let coordinator = HomeTabBarCoordinator()
            return .presentFullScreen(coordinator)
        case .login:
            let loginCoord = LoginCoordinator(rootViewController: self.rootViewController)
            addChild(loginCoord)
            return .trigger(LoginRoute.root, on: loginCoord)
        case .signUp:
            return .push(UIViewController())
        }
    }
}
