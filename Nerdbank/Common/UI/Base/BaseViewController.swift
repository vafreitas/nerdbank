//
//  BaseViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 11/12/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Properties
    
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    var navigationIsHidden: Bool {
        didSet {
            navigationController?.setNavigationBarHidden(navigationIsHidden, animated: true)
        }
    }
    
    var isLoading: Bool {
        didSet {
            if isLoading {
                self.view.addSubview(loadingIndicator)
                NSLayoutConstraint.activate([
                    loadingIndicator.centerXAnchor
                        .constraint(equalTo: self.view.centerXAnchor),
                    loadingIndicator.centerYAnchor
                        .constraint(equalTo: self.view.centerYAnchor),
                    loadingIndicator.widthAnchor
                        .constraint(equalToConstant: 50),
                    loadingIndicator.heightAnchor
                        .constraint(equalTo: self.loadingIndicator.widthAnchor)
                ])
                loadingIndicator.isAnimating = true
            } else {
                loadingIndicator.isAnimating = false
            }
        }
    }
    
    init() {
        self.isLoading = false
        self.navigationIsHidden = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
