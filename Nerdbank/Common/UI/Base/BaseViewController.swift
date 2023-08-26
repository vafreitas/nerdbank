//
//  BaseViewController.swift
//  Nerdbank
//
//  Created by Victor Alves de Freitas on 11/12/22.
//

import UIKit
import Toast

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
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    init() {
        self.isLoading = false
        self.navigationIsHidden = false
        let backButton = UIBarButtonItem()
        backButton.title = ""
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.backBarButtonItem = backButton
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UINavigationBar.appearance().tintColor = UIColor(named: "navbar-back")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
