//
//  SceneDelegate.swift
//  Westeros
//
//  Created by Aroa Miguel Garcia on 10/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let loginViewController = LoginViewController()



    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let navigationController = UINavigationController(rootViewController: loginViewController)

        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

