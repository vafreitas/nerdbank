//
//  WelcomeViewModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import XCoordinator

class WelcomeViewModel {
    let router: StrongRouter<WelcomeRoute>?
    
    init(router: StrongRouter<WelcomeRoute>? = nil) {
        self.router = router
    }
    
    func goToSignIn() {
        router?.trigger(.login)
    }
}
