//
//  HomeCoordinator.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 25/09/22.
//

import XCoordinator

enum HomeRoute: Route {
    case home
}

class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    init() {
        super.init(initialRoute: .home)
    }
    
    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .home:
            let viewModel = HomeViewModel()
            let viewController = HomeViewController(viewModel: viewModel)
            return .set([viewController])
        }
    }
}
