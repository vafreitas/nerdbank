//
//  HomeCoordinator.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import XCoordinator

enum HomeRoute: Route {
    case home
    case profile
}

class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    init() {
        super.init(initialRoute: .home)
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
        }
    }
}
