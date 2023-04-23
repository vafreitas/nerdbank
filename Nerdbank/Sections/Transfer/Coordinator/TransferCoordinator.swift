//
//  TransferCoordinator.swift
//  Nerdbank
//
//  Created by Victor Freitas on 22/04/23.
//

import XCoordinator
import UIKit

enum TransferRoute: Route {
    case transfer
}

class TransferCoordinator: NavigationCoordinator<TransferRoute> {
    
    init(rootViewController: UINavigationController) {
        super.init(rootViewController: rootViewController, initialRoute: .transfer)
    }
    
    override func prepareTransition(for route: TransferRoute) -> NavigationTransition {
        switch route {
        case .transfer:
            let viewModel = TransferViewModel()
            let viewController = TransferViewController(viewModel: viewModel)
            return .push(viewController)
        }
    }
}
