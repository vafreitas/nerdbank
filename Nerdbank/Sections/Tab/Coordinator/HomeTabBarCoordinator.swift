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
    private let extractRouter: StrongRouter<ExtractRoute>
    private let profileRouter: StrongRouter<ProfileRoute>
    
    // MARK: Initializer
    
    convenience init() {
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Home",
                                                                     image: .init(named: "tab_home_ico"),
                                                                     tag: 0)
        
        let extractCoordinator = ExtractListCoordinator()
        extractCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Extract",
                                                                        image: .init(named: "tab_extract_ico"),
                                                                        tag: 1)
        
        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Profile",
                                                                        image: .init(named: "tab_profile_ico"),
                                                                        tag: 2)
        
        self.init(homeRouter: homeCoordinator.strongRouter,
                  extractRouter: extractCoordinator.strongRouter,
                  profileRouter: profileCoordinator.strongRouter)
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = rootViewController.tabBar.bounds
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.roundCorners(radius: 29, corners: .allCorners)
        
        rootViewController.tabBar.tintColor = UIColor(hexString: "14955F")
        rootViewController.tabBar.shadowImage = UIImage()
        rootViewController.tabBar.backgroundImage = UIImage()
        rootViewController.tabBar.clipsToBounds = true
        rootViewController.tabBar.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.leftAnchor.constraint(equalTo: rootViewController.view.leftAnchor, constant: 16),
            blurView.rightAnchor.constraint(equalTo: rootViewController.view.rightAnchor, constant: -16),
            blurView.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    init(homeRouter: StrongRouter<HomeRoute>, extractRouter: StrongRouter<ExtractRoute>, profileRouter: StrongRouter<ProfileRoute>) {
        self.homeRouter = homeRouter
        self.extractRouter = extractRouter
        self.profileRouter = profileRouter
        super.init(tabs: [homeRouter, extractRouter, profileRouter], select: homeRouter)
    }
    
    override func prepareTransition(for route: TabBarRoute) -> TabBarTransition {
        switch route {
        case .home:
            return .select(homeRouter)
        case .extract:
            return .select(extractRouter)
        case .profile:
            return .select(profileRouter)
        }
    }
}
