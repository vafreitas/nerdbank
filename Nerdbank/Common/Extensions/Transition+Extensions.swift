//
//  Transition+Extensions.swift
//  Nerdbank
//
//  Created by Victor Freitas on 15/04/23.
//

import UIKit
import XCoordinator

extension Transition {
    static func presentFullScreen(_ presentable: Presentable, animation: Animation? = nil) -> Transition {
        presentable.viewController?.modalPresentationStyle = .fullScreen
        return .present(presentable, animation: animation)
    }

    static func dismissAll() -> Transition {
        return Transition(presentables: [], animationInUse: nil) { rootViewController, options, completion in
            guard let presentedViewController = rootViewController.presentedViewController else {
                completion?()
                return
            }
            presentedViewController.dismiss(animated: options.animated) {
                Transition.dismissAll()
                    .perform(on: rootViewController, with: options, completion: completion)
            }
        }
    }
}

