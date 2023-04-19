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
        }
    }
}
