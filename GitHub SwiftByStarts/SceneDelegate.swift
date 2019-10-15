//
//  SceneDelegate.swift
//  GitHub SwiftByStarts
//
//  Created by Filipe Catarino Merli on 14/10/19.
//  Copyright © 2019 Filipe Catarino Merli. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: Properties
    
    var window: UIWindow?

    // MARK: Class Functions

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ReposListTableViewController()
        window?.makeKeyAndVisible()
    }

}

