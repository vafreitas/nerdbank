//
//  AppDelegate.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import UIKit
import VFNetwork

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        VFNetwork.shared.configure([
            .timeout(30.0)
        ])
        
        VFSubject.shared.subscribe(self, for: .responseStatus)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// MARK: VFNetwork Observer Status Delegate

extension AppDelegate: VFNetworkObserver {
    func didResponseStatus(status: Status) {
        if status == .unauthorized {
            let user = Keychain.shared.get("user", LoginResponseModel.self)
            let refreshToken = UserRefreshTokenRequest(refreshToken: user?.refreshToken ?? "NA")
            LoginService().refreshToken(refreshToken) { result in
                switch result {
                case let .success(response):
                    if var user = Keychain.shared.get("user", LoginResponseModel.self) {
                        user.refreshToken = response.refreshToken
                        user.accessToken = response.accessToken
                        Keychain.shared.set("user", user)
                    }
                case let .failure(error):
                    debugPrint(error)
                }
            }
        }
    }
}

