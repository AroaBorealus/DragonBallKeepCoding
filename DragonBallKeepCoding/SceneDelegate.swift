//
//  SceneDelegate.swift
//  Westeros
//
//  Created by Aroa Miguel Garcia on 10/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let viewController = ViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

