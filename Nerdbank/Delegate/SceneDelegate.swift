//
//  SceneDelegate.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 23/09/22.
//

import UIKit
import LocalAuthentication

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let router = WelcomeCoordinator().strongRouter

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        router.setRoot(for: window ?? UIWindow(windowScene: windowScene))
        
//        if #available(iOS 13.0, *) {
//            if UITraitCollection.current.userInterfaceStyle == .dark {
//                window?.overrideUserInterfaceStyle = .dark
//            } else {
//                window?.overrideUserInterfaceStyle = .light
//            }
//        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
//        authenticateWithFaceID()
    }
    
    // MARK: Authentication
    
    func authenticateWithFaceID() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Autenticação necessária para acessar o aplicativo") { success, error in
                if success {
                    // Autenticação bem-sucedida, o usuário voltou ao aplicativo
                } else {
                    if let error = error as? LAError {
                        // Tratar erros de autenticação
                        print("Erro de autenticação: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            // O dispositivo não suporta autenticação biométrica
            print("Autenticação biométrica não disponível")
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

