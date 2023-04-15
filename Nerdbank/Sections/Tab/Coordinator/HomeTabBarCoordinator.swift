//
//  TabBarCoordinator.swift
//  Nerdbank
//
//  Created by Victor Freitas on 15/04/23.
//

import UIKit
import XCoordinator

enum TabBarRoute: Route {
    case home
    case extract
    case profile
}

class HomeTabBarCoordinator: TabBarCoordinator<TabBarRoute> {
    
    // MARK: Properties
    
    private let homeRouter: StrongRouter<HomeRoute>
    private let profileRouter: StrongRouter<ProfileRoute>
    
    // MARK: Initializer
    
    convenience init() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        self.init(homeRouter: homeCoordinator.strongRouter, profileRouter: profileCoordinator.strongRouter)
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = rootViewController.tabBar.bounds
        blurView.autoresizingMask = .flexibleHeight
        rootViewController.tabBar.insertSubview(blurView, at: 0)
    }
    
    init(homeRouter: StrongRouter<HomeRoute>, profileRouter: StrongRouter<ProfileRoute>) {
        self.homeRouter = homeRouter
        self.profileRouter = profileRouter
        super.init(tabs: [homeRouter, profileRouter], select: homeRouter)
    }
    
    override func prepareTransition(for route: TabBarRoute) -> TabBarTransition {
        switch route {
        case .home:
            return .select(homeRouter)
        case .extract:
            return .none()
        case .profile:
            return .select(profileRouter)
        }
    }
}
