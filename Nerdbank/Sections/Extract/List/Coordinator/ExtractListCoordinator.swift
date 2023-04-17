//
//  ExtractCoordinator.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 17/04/23.
//

import XCoordinator

enum ExtractRoute: Route {
    case extract
    case detail
}

class ExtractListCoordinator: NavigationCoordinator<ExtractRoute> {
    
    init() {
        super.init(initialRoute: .extract)
    }
    
    override func prepareTransition(for route: ExtractRoute) -> NavigationTransition {
        switch route {
        case .extract:
            let viewModel = ExtractListViewModel(router: weakRouter)
            let extractListVC = ExtractListViewController(viewModel: viewModel)
            return .set([extractListVC])
        case .detail:
            return .none()
        }
    }
}
