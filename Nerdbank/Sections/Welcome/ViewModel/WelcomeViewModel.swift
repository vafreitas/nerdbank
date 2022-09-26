//
//  WelcomeViewModel.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import XCoordinator

class WelcomeViewModel {
    let router: UnownedRouter<WelcomeRoute>
    
    init(router: UnownedRouter<WelcomeRoute>) {
        self.router = router
    }
    
    func goToSignIn() {
        router.trigger(.login)
    }
}
